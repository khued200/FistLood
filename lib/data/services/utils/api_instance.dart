import 'package:dio/dio.dart';
import 'package:shopping_conv/utils/auth_storage_util.dart';

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
        if (options.extra['requiresToken'] && options.extra['requiresToken'] == true) {
          // // Remove the auxiliary header
          // options.headers.remove('requiresToken');
          // Get the token
          _getAccessToken().then((token) {
            // Add the token to the header
            options.headers['Authorization'] = 'Bearer $token';
            handler.next(options); // Continue the request
          });
        }
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

  Future<String?> _getAccessToken() async {
    // Get the token from the storage
    var accessToken = await AuthStorage.getAuthAccessToken();
    return accessToken;
  }
}
