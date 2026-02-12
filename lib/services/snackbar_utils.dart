import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

void showErrorMessage(dynamic message, {Widget? icon}) {
  HapticFeedback.heavyImpact();
  toastification.dismissAll();
  toastification.show(
    title: Text(message.toString()),
    type: ToastificationType.error,
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 3),
    icon: icon,
  );
}

void showSuccessMessage(dynamic message, {Widget? icon}) {
  toastification.dismissAll();
  toastification.show(
    title: Text(message),
    type: ToastificationType.success,
    style: ToastificationStyle.minimal,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 3),
    icon: icon,
  );
}
