import 'package:flutter/material.dart';
import '../../../../services/shared_preferences_services.dart';
import '../../../../services/snackbar_utils.dart';
import '../../../core/app_route.dart';
import '../../../core/repository.dart';
import '../../home_screen/home_screen.dart';

mixin EmailPasswordMixin<T extends StatefulWidget> on State<T> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool loginButtonLoading = false;
  bool passwordVisible = false;

  final formKey = GlobalKey<FormState>(debugLabel: 'login_form_key');

  void setButtonLoading(bool isLoading) {
    setState(() {
      loginButtonLoading = isLoading;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  bool validate() {
    bool valid = false;
    if (!formKey.currentState!.validate()) {
      return valid;
    } else {
      valid = true;
    }
    return valid;
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return "Email is required";

    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) return "Password is required";
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  Future<void> signInWithEmailAndPassword({
    required VoidCallback onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) return;

    setButtonLoading(true);
    try {
      final response = await DataRepository.i.login(
        username: emailController.text,
        password: passwordController.text,
      );

      if (response.data['status'] == true) {
        await SharedPreferencesService.i.setValue(
          value: response.data['token'],
        );
      }

      if (mounted) {
        showSuccessMessage(response.data['message']);
      }

      if (mounted) {
        navigate(context, HomeScreen.path, replace: true);
      }

      setButtonLoading(false);

      onSuccess();
    } catch (e) {
      setButtonLoading(false);
      showErrorMessage(e);
    }
  }
}
