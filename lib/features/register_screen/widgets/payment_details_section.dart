import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/theme/theme.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

import 'register_form_scope.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = RegisterFormScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Total Amount',
          hintText: '',
          controller: state.totalAmountController,
          keyboardType: TextInputType.number,
          readOnly: true,
          validator: state.totalAmountValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Discount Amount',
          hintText: '',
          controller: state.discountAmountController,
          keyboardType: TextInputType.number,
          onChanged: (val) => state.updateBalance(),
          validator: state.discountAmountValidator,
        ),
        gapLarge,

        Text(
          'Payment Option',
          style: context.poppins50014.copyWith(color: const Color(0xFF333333)),
        ),
        gap,
        ValueListenableBuilder<String>(
          valueListenable: state.selectedPaymentNotifier,
          builder: (context, selectedPayment, _) {
            const options = ['Cash', 'Card', 'UPI'];
            return FormField<String>(
              initialValue: selectedPayment,
              validator: state.paymentOptionValidator,
              builder: (formFieldState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioGroup<String>(
                      groupValue: selectedPayment,
                      onChanged: (val) {
                        if (val != null) {
                          state.selectedPaymentNotifier.value = val;
                          formFieldState.didChange(val);
                        }
                      },
                      child: Row(
                        children: options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: GestureDetector(
                              onTap: () {
                                state.selectedPaymentNotifier.value = option;
                                formFieldState.didChange(option);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: option,
                                    activeColor: primaryColor,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  Text(option, style: context.poppins40014),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    if (formFieldState.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Text(
                          formFieldState.errorText ?? '',
                          style: baseStyle.copyWith(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
        gapLarge,

        AppTextField(
          label: 'Advance Amount',
          hintText: '',
          controller: state.advanceAmountController,
          keyboardType: TextInputType.number,
          onChanged: (val) => state.updateBalance(),
          validator: state.advanceAmountValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Balance Amount',
          hintText: '',
          controller: state.balanceAmountController,
          keyboardType: TextInputType.number,
          readOnly: true,
          validator: state.balanceAmountValidator,
        ),
      ],
    );
  }
}
