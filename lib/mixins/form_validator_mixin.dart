import 'package:flutter/material.dart';

mixin FormValidatorMixin<T extends StatefulWidget> on State<T> {
  bool buttonLoading = false;
  void makeButtonLoading() {
    buttonLoading = true;
    setState(() {});
  }

  void makeButtonNotLoading() {
    buttonLoading = false;
    setState(() {});
  }

  String debugLabel = "form_key_debug_label";

  bool dataChanged = false;

  void makeDataChanged() {
    setState(() {
      dataChanged = true;
    });
  }

  ScrollController formScrollController = ScrollController();

  @override
  initState() {
    super.initState();
    formKey = GlobalKey<FormState>(debugLabel: debugLabel);
  }

  GlobalKey<FormState>? formKey;
  bool validate() {
    if (formKey == null) return false;
    if (!formKey!.currentState!.validate()) {
      scrollToFirstError();
      return false;
    }
    return true;
  }

  void scrollToFirstError() {
    final context = formKey?.currentContext;
    if (context == null) return;

    FormFieldState? firstError;

    void findError(Element element) {
      if (firstError != null) return;

      if (element.widget is FormField) {
        final StatefulElement statefulElement = element as StatefulElement;
        final FormFieldState state = statefulElement.state as FormFieldState;

        if (state.hasError) {
          firstError = state;
          return;
        }
      }

      element.visitChildren(findError);
    }

    context.visitChildElements(findError);

    if (firstError != null && firstError!.mounted) {
      Scrollable.ensureVisible(
        firstError!.context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        alignment: 0.1,
      );
    }
  }
}
