import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'main.dart';

class AppConfigLocal extends AppConfig {
  @override
  String get domain => "flutter-amr.noviindus.in";

  @override
  String get slugUrl => "/api/";

  @override
  String get port => "";

  @override
  String get scheme => "https";

  @override
  ENV get env => ENV.local;
}

void main() async {
  appConfig = AppConfigLocal();
  await mainCommon();
  runApp(const MyApp());
}
