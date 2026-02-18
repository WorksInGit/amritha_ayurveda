import 'package:flutter/material.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:amritha_ayurveda/widgets/selection_bottom_sheet.dart';

class AppDropdownField<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final T? value;
  final List<T> items;
  final String Function(T) displayText;
  final ValueChanged<T?> onChanged;
  final bool enabled;
  final String? Function(T?)? validator;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    this.value,
    required this.items,
    required this.displayText,
    required this.onChanged,
    this.enabled = true,
    this.validator,
  });

  @override
  State<AppDropdownField<T>> createState() => _AppDropdownFieldState<T>();
}

class _AppDropdownFieldState<T> extends State<AppDropdownField<T>> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value != null ? widget.displayText(widget.value as T) : '',
    );
  }

  @override
  void didUpdateWidget(covariant AppDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = widget.value != null
              ? widget.displayText(widget.value as T)
              : 'N/A';
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showBottomSheet() async {
    final result = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet<T>(
        title: widget.label,
        items: widget.items,
        selectedItem: widget.value,
        displayText: widget.displayText,
      ),
    );

    if (result != null && mounted) {
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      hintText: widget.hintText,
      controller: _controller,
      readOnly: true,
      onTap: widget.enabled ? _showBottomSheet : null,
      validator: (_) => widget.validator?.call(widget.value),
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xFF006837),
      ),
    );
  }
}
