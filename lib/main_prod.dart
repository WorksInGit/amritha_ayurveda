import 'package:flutter/material.dart';

import 'core/app_config.dart';
import 'main.dart';

class AppConfigProd extends AppConfig {
  @override
  String get domain => "";

  @override
  String get slugUrl => "";

  @override
  String get port => "";

  @override
  String get scheme => "";

  @override
  ENV get env => ENV.prod;
}

void main() async {
  appConfig = AppConfigProd();
  await mainCommon();
  runApp(const MyApp());
}
