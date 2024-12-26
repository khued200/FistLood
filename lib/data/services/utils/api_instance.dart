import 'package:dio/dio.dart';

class ApiService {
  static const baseURL = "http://localhost:8080";
  final Dio _dio;


  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: baseURL, // Set your API base URL
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options); // Continue the request
      },
      onResponse: (response, handler) {
        // Add custom response logic
        handler.next(response); // Continue the response
      },
      onError: (DioError e, handler) {
        // Handle errors globally
        handler.next(e); // Continue the error
      },
    ));
  }

  Dio get dio => _dio;
}
