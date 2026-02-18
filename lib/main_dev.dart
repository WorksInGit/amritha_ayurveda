import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'main.dart';

class AppConfigDev extends AppConfig {
  @override
  String get domain => "flutter-amr.noviindus.in";

  @override
  String get slugUrl => "/api/";

  @override
  String get port => "";

  @override
  String get scheme => "https";

  @override
  ENV get env => ENV.dev;
}

void main() async {
  appConfig = AppConfigDev();
  await mainCommon();
  runApp(const MyApp());
}
