import 'dart:core';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'app_config.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'token_auth_interceptor.dart';

class DataRepository {
  final Dio _client;

  DataRepository._(this._client);

  /// Factory method to create and initialize the repository
  static Future<DataRepository> create() async {
    final client = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        baseUrl: appConfig.baseUrl,
        contentType: "application/json",
      ),
    );

    final cookieJar = CookieJar(ignoreExpires: false);
    client.interceptors.add(CookieManager(cookieJar));
    client.interceptors.add(TokenAuthInterceptor());
    client.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
        compact: true,
      ),
    );
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await Future.delayed(const Duration(seconds: 1));
          handler.next(options);
        },
      ),
    );

    return DataRepository._(client);
  }

  // Singleton instance
  static DataRepository? _instance;
  static DataRepository get i {
    if (_instance == null) {
      throw StateError(
        'DataRepository.i accessed before initialization. '
        'Ensure DataRepository.create() is called and assigned to _instance.',
      );
    }
    return _instance!;
  }

  // Initialize the singleton
  static Future<void> initialize() async {
    _instance = await create();
  }

  void setBaseUrl(String text) {
    _client.options.baseUrl = text + appConfig.slugUrl;
  }
}
