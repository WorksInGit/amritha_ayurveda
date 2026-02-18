import 'package:flutter/material.dart';
import '../register_screen.dart';

class RegisterFormScope extends InheritedWidget {
  final RegisterScreenState state;

  const RegisterFormScope({
    super.key,
    required this.state,
    required super.child,
  });

  static RegisterScreenState of(BuildContext context) {
    final RegisterFormScope? result = context
        .dependOnInheritedWidgetOfExactType<RegisterFormScope>();
    assert(result != null, 'No RegisterFormScope found in context');
    return result!.state;
  }

  @override
  bool updateShouldNotify(RegisterFormScope oldWidget) {
    return state != oldWidget.state;
  }
}
