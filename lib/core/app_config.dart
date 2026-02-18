import 'package:get/get.dart';

import '../main_dev.dart';
import '../main_local.dart';
import '../main_prod.dart';

late final AppConfig appConfig;

enum ENV {
  local,
  dev,
  prod;

  AppConfig get appConfig {
    switch (this) {
      case ENV.local:
        return AppConfigLocal();
      case ENV.dev:
        return AppConfigDev();
      case ENV.prod:
        return AppConfigProd();
    }
  }

  static ENV fromValue(dynamic value) {
    return ENV.values.firstWhereOrNull((element) => element.index == value) ??
        ENV.local;
  }
}

abstract class AppConfig {
  ENV get env;
  String get scheme;
  String get port;
  String get domain;
  String get slugUrl;

  String get baseUrl {
    return "$scheme://$domain:$port$slugUrl";
  }
}
