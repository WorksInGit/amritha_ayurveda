import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import 'register_form_scope.dart';

class AmountDetailsSection extends StatelessWidget {
  const AmountDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = RegisterFormScope.of(context);

    return Column(
      children: [
        AppTextField(
          label: 'Total Amount',
          hintText: '',
          controller: state.totalAmountController, // state is now available
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: state.totalAmountValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Discount Amount',
          hintText: '',
          controller: state.discountAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: state.discountAmountValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Advance Amount',
          hintText: '',
          controller: state.advanceAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: state.advanceAmountValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Balance Amount',
          hintText: '',
          controller: state.balanceAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: state.balanceAmountValidator,
        ),
      ],
    );
  }
}
