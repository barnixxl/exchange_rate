import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException({required this.message, this.statusCode});

  @override
  String toString() => 'NetworkException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class Network {
  late final Dio _dio;

  Network() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.nbrb.by/exrates/', //https://api.nbrb.by/exrates/
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw NetworkException(message: ': неизвестная ошибка: $e');
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) { // в каждом кейсе прописываем вид ошибки/ошибок после которых выбрасываем сообщение
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(message: ': время соединения вышло');

      case DioExceptionType.badCertificate:
        throw NetworkException(message: ': ошибка подключения API');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _getErrorMessageByStatusCode(statusCode);
        throw NetworkException(message: ': ошибка подключения API (неверная ссылка), код ошибки:  $statusCode');

      case DioExceptionType.cancel:
        throw NetworkException(message: ': запрос не был отправлен');

      case DioExceptionType.connectionError:
        throw NetworkException(message: ': проверьте соединение с интернетом');

      case DioExceptionType.unknown:
        if (e.error is FormatException) {
          throw NetworkException(message: ': ошибка формата данных');
        }
        throw NetworkException(message: ': неизвестная ошибка сети');
    }
  }

  String _getErrorMessageByStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Неверный запрос';
      case 401:
        return 'Не авторизован';
      case 403:
        return 'Доступ запрещен';
      case 404:
        return 'Ресурс не найден';
      case 500:
        return 'Ошибка на стороне сервера';
      case 502:
      case 503:
      case 504:
        return 'Сервер временно недоступен';
      default:
        return 'Ошибка на стороне сервера (код ошибки: $statusCode)';
    }
  }
}