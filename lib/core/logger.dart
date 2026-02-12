import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

void logInfo(dynamic msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[34m$jsonData\x1B[0m');
  }
}

void logSuccess(dynamic msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[32m$jsonData\x1B[0m');
  }
}

void logWarning(dynamic msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[33m$jsonData\x1B[0m');
  }
}

void logError(dynamic msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[31m$jsonData\x1B[0m');
  }
}
