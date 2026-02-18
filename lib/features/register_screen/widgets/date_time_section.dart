import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'register_form_scope.dart';

import '../../../core/extenstion.dart';
import '../../../theme/theme.dart';

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = RegisterFormScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treatment Date',
          style: context.poppins40016.copyWith(color: appBlackColor),
        ),
        gap,
        ValueListenableBuilder<DateTime?>(
          valueListenable: state.selectedDateNotifier,
          builder: (context, selectedDate, _) {
            return FormField<DateTime>(
              initialValue: selectedDate,
              validator: (val) {
                if (selectedDate == null) {
                  return 'Please select a treatment date';
                }
                return null;
              },
              builder: (formFieldState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await state.pickDate(context);
                        formFieldState.didChange(
                          state.selectedDateNotifier.value,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.w,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0x40D9D9D9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedDate?.dayMonthYear ?? 'N/A',
                              style: context.poppins40016,
                            ),
                            Icon(
                              Icons.calendar_today,
                              size: 20.r,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (formFieldState.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Text(
                          formFieldState.errorText ?? '',
                          style: context.poppins40012.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class TimePickerSection extends StatelessWidget {
  const TimePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = RegisterFormScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treatment Time',
          style: context.poppins40016.copyWith(color: appBlackColor),
        ),
        gap,
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder<int?>(
                valueListenable: state.selectedHourNotifier,
                builder: (context, selectedHour, _) {
                  return AppDropdownField<int>(
                    label: '',
                    hintText: 'Hour',
                    value: selectedHour,
                    items: List.generate(24, (i) => i),
                    displayText: (h) => h.toString().padLeft(2, '0'),
                    onChanged: (val) => state.selectedHourNotifier.value = val,
                    validator: (val) {
                      if (val == null) return 'Required';
                      return null;
                    },
                  );
                },
              ),
            ),
            gapLarge,
            Expanded(
              child: ValueListenableBuilder<int?>(
                valueListenable: state.selectedMinuteNotifier,
                builder: (context, selectedMinute, _) {
                  return AppDropdownField<int>(
                    label: '',
                    hintText: 'Minutes',
                    value: selectedMinute,
                    items: List.generate(60, (i) => i),
                    displayText: (m) => m.toString().padLeft(2, '0'),
                    onChanged: (val) =>
                        state.selectedMinuteNotifier.value = val,
                    validator: (val) {
                      if (val == null) return 'Required';
                      return null;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
