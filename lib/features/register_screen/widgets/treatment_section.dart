import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/features/register_screen/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:amritha_ayurveda/theme/theme.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../register_screen.dart';
import 'counter_row.dart';
import 'register_form_scope.dart';
import 'treatment_card.dart';

class TreatmentSection extends StatelessWidget {
  const TreatmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = RegisterFormScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treatments',
          style: context.poppins40016.copyWith(color: appBlackColor),
        ),
        gap,
        ValueListenableBuilder<List<SelectedTreatment>>(
          valueListenable: state.selectedTreatmentsNotifier,
          builder: (context, selectedTreatments, _) {
            return Column(
              children: selectedTreatments.asMap().entries.map((entry) {
                final index = entry.key;
                final st = entry.value;
                return TreatmentCard(
                  index: index,
                  selectedTreatment: st,
                  onRemove: () {
                    final list = List<SelectedTreatment>.from(
                      state.selectedTreatmentsNotifier.value,
                    );
                    list.removeAt(index);
                    state.selectedTreatmentsNotifier.value = list;
                    state.updateCalculations();
                  },
                  onEdit: () => showEditDialog(context, st, state),
                );
              }).toList(),
            );
          },
        ),

        SizedBox(
          width: double.infinity,
          child: ValueListenableBuilder<bool>(
            valueListenable: state.isTreatmentsLoadingNotifier,
            builder: (context, isLoading, _) {
              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () => showAddSheet(context, state),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor.withValues(alpha: 0.15),
                  foregroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: primaryColor,
                        ),
                      )
                    : Text('+ Add Treatments', style: context.poppins60014),
              );
            },
          ),
        ),
      ],
    );
  }

  void showAddSheet(BuildContext context, RegisterScreenState state) {
    if (state.selectedBranchNotifier.value == null) {
      showErrorMessage('Please select a branch');
      return;
    }

    if (state.treatmentsNotifier.value.isEmpty) {
      showErrorMessage('No treatments available');
      return;
    }

    final availableTreatments = state.treatmentsNotifier.value
        .where(
          (t) => !state.selectedTreatmentsNotifier.value.any(
            (st) => st.treatment.id == t.id,
          ),
        )
        .toList();

    if (availableTreatments.isEmpty) {
      showErrorMessage('All treatments have been added');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTreatmentSheet(
        treatments: availableTreatments,
        onSave: (st) {
          final list = List<SelectedTreatment>.from(
            state.selectedTreatmentsNotifier.value,
          );
          list.add(st);
          state.selectedTreatmentsNotifier.value = list;
          state.updateCalculations();
        },
      ),
    );
  }

  void showEditDialog(
    BuildContext context,
    SelectedTreatment st,
    RegisterScreenState state,
  ) {
    final availableTreatments = state.treatmentsNotifier.value
        .where(
          (t) =>
              t.id == st.treatment.id ||
              !state.selectedTreatmentsNotifier.value.any(
                (selected) => selected.treatment.id == t.id,
              ),
        )
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTreatmentSheet(
        treatments: availableTreatments,
        initialSelection: st,
        onSave: (newSt) {
          st.treatment = newSt.treatment;
          st.maleCount = newSt.maleCount;
          st.femaleCount = newSt.femaleCount;

          state.selectedTreatmentsNotifier.value = List.from(
            state.selectedTreatmentsNotifier.value,
          );
          state.updateCalculations();
        },
      ),
    );
  }
}

class AddTreatmentSheet extends StatefulWidget {
  final List<Treatment> treatments;
  final SelectedTreatment? initialSelection;
  final ValueChanged<SelectedTreatment> onSave;

  const AddTreatmentSheet({
    super.key,
    required this.treatments,
    this.initialSelection,
    required this.onSave,
  });

  @override
  State<AddTreatmentSheet> createState() => _AddTreatmentSheetState();
}

class _AddTreatmentSheetState extends State<AddTreatmentSheet> {
  Treatment? selectedTreatment;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelection != null) {
      selectedTreatment = widget.initialSelection!.treatment;
      maleCount = widget.initialSelection!.maleCount;
      femaleCount = widget.initialSelection!.femaleCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Gap(20.w),
          Row(
            children: [
              Text('Choose Treatment', style: context.poppins50018),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 24.r),
              ),
            ],
          ),
          Gap(12.w),
          AppDropdownField<Treatment>(
            label: '',
            hintText: 'Choose preferred treatment',
            value: selectedTreatment,
            items: widget.treatments,
            displayText: (t) => t.name ?? 'N/A',
            onChanged: (val) => setState(() => selectedTreatment = val),
          ),
          Gap(24.w),
          Text(
            'Add Patients',
            style: context.poppins50018.copyWith(fontSize: 18.fSize),
          ),
          Gap(12.w),
          CounterRow(
            label: 'Male',
            count: maleCount,
            onIncrement: () => setState(() => maleCount++),
            onDecrement: () => setState(() {
              if (maleCount > 0) maleCount--;
            }),
          ),
          gapLarge,
          CounterRow(
            label: 'Female',
            count: femaleCount,
            onIncrement: () => setState(() => femaleCount++),
            onDecrement: () => setState(() {
              if (femaleCount > 0) femaleCount--;
            }),
          ),
          Gap(30.w),
          AppButton(
            text: 'Save',
            onPressed: () {
              if (selectedTreatment == null) {
                showErrorMessage('Please select a treatment');
                return;
              }
              if (maleCount == 0 && femaleCount == 0) {
                showErrorMessage('Please add at least one patient');
                return;
              }
              widget.onSave(
                SelectedTreatment(
                  treatment: selectedTreatment!,
                  maleCount: maleCount,
                  femaleCount: femaleCount,
                ),
              );
              Navigator.pop(context);
            },
          ),
          Gap(20.w),
        ],
      ),
    );
  }
}
