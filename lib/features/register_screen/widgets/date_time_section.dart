import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerSection extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const DatePickerSection({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: selectedDate,
      validator: (_) {
        if (selectedDate == null) {
          return 'Treatment date is required';
        }
        return null;
      },
      builder: (FormFieldState<DateTime> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Treatment Date',
              style: TextStyle(
                fontSize: 14.fSize,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF333333),
              ),
            ),
            gap,
            GestureDetector(
              onTap: () {
                onTap();
                state.didChange(selectedDate);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: state.hasError ? Colors.red : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                          : '',
                      style: TextStyle(fontSize: 14.fSize),
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 20.fSize,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12.fSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class TimePickerSection extends StatelessWidget {
  final int? selectedHour;
  final int? selectedMinute;
  final ValueChanged<int?> onHourChanged;
  final ValueChanged<int?> onMinuteChanged;

  const TimePickerSection({
    super.key,
    required this.selectedHour,
    required this.selectedMinute,
    required this.onHourChanged,
    required this.onMinuteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treatment Time',
          style: TextStyle(
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        gap,
        Row(
          children: [
            Expanded(
              child: AppDropdownField<int>(
                label: '',
                hintText: 'Hour',
                value: selectedHour,
                items: List.generate(12, (i) => i + 1),
                displayText: (h) => h.toString().padLeft(2, '0'),
                onChanged: onHourChanged,
                validator: (val) {
                  if (val == null) {
                    return 'Hour is required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppDropdownField<int>(
                label: '',
                hintText: 'Minutes',
                value: selectedMinute,
                items: List.generate(60, (i) => i),
                displayText: (m) => m.toString().padLeft(2, '0'),
                onChanged: onMinuteChanged,
                validator: (val) {
                  if (val == null) {
                    return 'Minute is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
