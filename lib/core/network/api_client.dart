import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amritha_ayurveda/core/constants/api_constants.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] =
                'Bearer $token'; // Adjust scheme if needed (e.g. just token)
          }
          // The API prompt mentions sending keys in FormData.
          // If the request data is a Map, we might need to convert it to FormData for specific endpoints
          // usually usually retrofit handles this if we annotate @Part.
          // But if we need manual handling:
          if (options.data is Map<String, dynamic> &&
              options.contentType == Headers.multipartFormDataContentType) {
            options.data = FormData.fromMap(options.data);
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Handle global errors here (e.g. 401 Unauthorized -> Logout)
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
