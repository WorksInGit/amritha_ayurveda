import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountDetailsSection extends StatelessWidget {
  final TextEditingController totalAmountController;
  final TextEditingController discountAmountController;
  final TextEditingController advanceAmountController;
  final TextEditingController balanceAmountController;

  const AmountDetailsSection({
    super.key,
    required this.totalAmountController,
    required this.discountAmountController,
    required this.advanceAmountController,
    required this.balanceAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          label: 'Total Amount',
          hintText: '',
          controller: totalAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Total amount is required';
            }
            final amount = double.tryParse(v.trim());
            if (amount == null || amount < 0) {
              return 'Enter a valid amount';
            }
            return null;
          },
        ),
        gapLarge,
        AppTextField(
          label: 'Discount Amount',
          hintText: '',
          controller: discountAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Discount amount is required';
            }
            final discount = double.tryParse(v.trim());
            if (discount == null || discount < 0) {
              return 'Enter a valid amount';
            }
            final total =
                double.tryParse(totalAmountController.text.trim()) ?? 0;
            if (discount > total) {
              return 'Discount cannot exceed total amount';
            }
            return null;
          },
        ),
        gapLarge,
        AppTextField(
          label: 'Advance Amount',
          hintText: '',
          controller: advanceAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Advance amount is required';
            }
            final amount = double.tryParse(v.trim());
            if (amount == null || amount < 0) {
              return 'Enter a valid amount';
            }
            return null;
          },
        ),
        gapLarge,
        AppTextField(
          label: 'Balance Amount',
          hintText: '',
          controller: balanceAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Balance amount is required';
            }
            final amount = double.tryParse(v.trim());
            if (amount == null || amount < 0) {
              return 'Enter a valid amount';
            }
            return null;
          },
        ),
      ],
    );
  }
}
