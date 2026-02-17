import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:flutter/material.dart';

class PaymentOptionSection extends StatelessWidget {
  final String selectedPayment;
  final ValueChanged<String> onChanged;

  const PaymentOptionSection({
    super.key,
    required this.selectedPayment,
    required this.onChanged,
  });

  static const _options = ['Cash', 'Card', 'UPI'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Option',
          style: TextStyle(
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        gap,
        Row(
          children: _options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(right: 24),
              child: GestureDetector(
                onTap: () => onChanged(option),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: selectedPayment,
                      activeColor: primaryColor,
                      onChanged: (val) => onChanged(val!),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(option, style: TextStyle(fontSize: 14.fSize)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
