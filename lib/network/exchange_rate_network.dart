import 'package:dio/dio.dart';

class Network {
  late final Dio _dio;

  Network() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.nbrb.by/exrates/',                                                                                //https://api.nbrb.by/exrates/
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
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
        Map<String, dynamic>?
        queryParameters,
      }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters:
        queryParameters,
      );
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    } catch (e) {
      throw Exception(
          'Неизвестная ошибка: $e'
      );
    }
  }
  Exception _mapDioErrorToException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw Exception(
            'Время соединения вышло'
        );

      case DioExceptionType.badCertificate:
        throw Exception(
            'Ошибка подключения API'
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _getErrorMessageByStatusCode(statusCode);
        throw Exception(
            'Ошибка подключения API (неверная ссылка), код ошибки:  $statusCode'
        );

      case DioExceptionType.cancel:
        throw Exception(
            'Запрос не был отправлен'
        );

      case DioExceptionType.connectionError:
        throw Exception(
            'Проверьте соединение с интернетом'
        );

      case DioExceptionType.unknown:
        if (e.error is FormatException) {
          throw Exception(
              'Ошибка формата данных'
          );
        }
        throw Exception(
            'Неизвестная ошибка сети'
        );
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
