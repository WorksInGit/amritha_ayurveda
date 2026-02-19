import 'package:amritha_ayurveda/core/repository.dart';
import 'package:amritha_ayurveda/features/register_screen/models/branch_model.dart';
import 'package:amritha_ayurveda/features/register_screen/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:flutter/material.dart';

import '../register_screen.dart';

mixin RegisterDataMixin<T extends StatefulWidget> on State<T> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();

  final selectedLocationNotifier = ValueNotifier<String?>(null);
  final selectedBranchNotifier = ValueNotifier<Branch?>(null);
  final selectedPaymentNotifier = ValueNotifier<String>('');
  final selectedDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedHourNotifier = ValueNotifier<int?>(null);
  final selectedMinuteNotifier = ValueNotifier<int?>(null);

  final branchesNotifier = ValueNotifier<List<Branch>>([]);
  final treatmentsNotifier = ValueNotifier<List<Treatment>>([]);
  final selectedTreatmentsNotifier = ValueNotifier<List<SelectedTreatment>>([]);

  final isLoadingDataNotifier = ValueNotifier<bool>(true);
  final isTreatmentsLoadingNotifier = ValueNotifier<bool>(false);

  static const locations = [
    'Kozhikode',
    'Kochi',
    'Thiruvananthapuram',
    'Thrissur',
    'Kannur',
    'Kottayam',
    'Alappuzha',
    'Palakkad',
    'Malappuram',
    'Kollam',
    'Idukki',
    'Ernakulam',
    'Wayanad',
    'Pathanamthitta',
    'Kumarakom',
  ];

  void disposeControllers() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();

    selectedLocationNotifier.dispose();
    selectedBranchNotifier.dispose();
    selectedPaymentNotifier.dispose();
    selectedDateNotifier.dispose();
    selectedHourNotifier.dispose();
    selectedMinuteNotifier.dispose();
    branchesNotifier.dispose();
    treatmentsNotifier.dispose();
    selectedTreatmentsNotifier.dispose();
    isLoadingDataNotifier.dispose();
    isTreatmentsLoadingNotifier.dispose();
  }

  Future<void> loadBranches() async {
    try {
      final result = await DataRepository.i.getBranchList();
      if (mounted) {
        branchesNotifier.value = result;
        isLoadingDataNotifier.value = false;
      }
    } catch (e) {
      if (mounted) {
        isLoadingDataNotifier.value = false;
        showErrorMessage(e.toString());
      }
    }
  }

  Future<void> loadTreatments() async {
    isTreatmentsLoadingNotifier.value = true;
    try {
      final result = await DataRepository.i.getTreatmentList(
        branchId: selectedBranchNotifier.value?.id ?? 0,
      );
      if (mounted) {
        treatmentsNotifier.value = result;
        selectedTreatmentsNotifier.value = [];
        isTreatmentsLoadingNotifier.value = false;
      }
    } catch (e) {
      if (mounted) {
        isTreatmentsLoadingNotifier.value = false;
        showErrorMessage(e.toString());
      }
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDateNotifier.value ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF006837)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDateNotifier.value = picked;
    }
  }
}
