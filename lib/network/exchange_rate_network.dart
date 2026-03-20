import 'package:dio/dio.dart';

class ExchangeRateNetwork {
  static const String _baseUrl = 'https://api.nbrb.by/exrates/';
  late final Dio _dio;

  ExchangeRateNetwork() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(
          seconds: 20,
        ),
        receiveTimeout: const Duration(
          seconds: 20,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  Exception _mapDioErrorToException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Время соединения вышло',
        );
      case DioExceptionType.badCertificate:
        return Exception(
          'Ошибка подключения API',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _getErrorMessageByStatusCode(statusCode);
        return Exception(
          'Ошибка подключения API (неверная ссылка), текст ошибки:  $message',
        );
      case DioExceptionType.cancel:
        return Exception(
          'Запрос не был отправлен',
        );
      case DioExceptionType.connectionError:
        return Exception(
          'Проверьте соединение с интернетом',
        );
      case DioExceptionType.unknown:
        if (e.error is FormatException) {
          return Exception(
            'Ошибка формата данных',
          );
        }
        return Exception(
          'Неизвестная ошибка сети',
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
