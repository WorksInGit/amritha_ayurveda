import 'package:flutter/material.dart';
import '../constants.dart';

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
    bool valid = false;
    if (!formKey!.currentState!.validate()) {
    } else {
      valid = true;
    }
    if (!valid) {
      scrollToTop();
    }
    return valid;
  }

  void tougleScroll() {
    if (!formScrollController.hasClients) return;
    if (atBottom()) {
      scrollToTop();
    } else {
      scrollToBottom();
    }
  }

  bool atBottom() {
    if (!formScrollController.hasClients) return false;
    if (formScrollController.position.pixels ==
        formScrollController.position.maxScrollExtent) {
      return true;
    }
    return false;
  }

  void scrollToTop() {
    if (!formScrollController.hasClients) return;
    formScrollController.animateTo(
      0,
      duration: animationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  void scrollToBottom() {
    if (!formScrollController.hasClients) return;
    formScrollController.animateTo(
      formScrollController.position.maxScrollExtent,
      duration: animationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }
}
