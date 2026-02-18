import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import '../features/login_screen/login_screen.dart';
import '../main.dart';
import '../services/shared_preferences_services.dart';
import 'app_route.dart';

class TokenAuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = await SharedPreferencesService.i.getValue();
    if (token != "") {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    options.headers.addAll({
      "User-Agent": Platform.isAndroid ? "ANDROID" : "IOS",
      "Accept": Headers.jsonContentType,
    });
    if (options.data == null) {
      options.headers.remove(Headers.contentTypeHeader);
    } else if (options.data is FormData) {
      options.headers[Headers.contentTypeHeader] =
          Headers.multipartFormDataContentType;
    } else {
      options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401:
        var data = err.response?.data;
        bool requiresVerification = false;
        if (data is Map &&
            data['error'] is Map &&
            data['error']['requires_verification'] is List &&
            (data['error']['requires_verification'] as List).contains("True")) {
          requiresVerification = true;
        }

        if (!requiresVerification) {
          signOut();
        }
        break;
      case 403:
        var data = err.response?.data;
        if (data is Map &&
            data['message'] ==
                "You do not have permission to perform this action.") {
          signOut();
        }
        break;
      default:
        break;
    }
    super.onError(err, handler);
  }
}

Future<void> signOut() async {
  await SharedPreferencesService.i.clear();

  navigate(navigatorKey.currentContext!, LoginScreen.path, replace: true);
}
