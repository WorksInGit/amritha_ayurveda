import 'package:amritha_ayurveda/core/repository.dart';
import 'package:amritha_ayurveda/models/branch_model.dart';
import 'package:amritha_ayurveda/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:flutter/material.dart';

import '../register_screen.dart';

/// Mixin that manages all form controllers, state variables, and data loading
/// for the Register screen.
mixin RegisterDataMixin<T extends StatefulWidget> on State<T> {
  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();

  // Dropdown values
  String? selectedLocation;
  Branch? selectedBranch;
  String selectedPayment = 'Cash';
  DateTime? selectedDate;
  int? selectedHour;
  int? selectedMinute;

  // Data lists
  List<Branch> branches = [];
  List<Treatment> treatments = [];
  final List<SelectedTreatment> selectedTreatments = [];

  // Loading state
  bool isLoadingData = true;

  // Static location list
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
  }

  Future<void> loadBranches() async {
    try {
      final result = await DataRepository.i.getBranchList();
      if (mounted) {
        setState(() {
          branches = result;
          isLoadingData = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoadingData = false);
        showErrorMessage(e.toString());
      }
    }
  }

  Future<void> loadTreatments() async {
    try {
      final result = await DataRepository.i.getTreatmentList(
        branchId: selectedBranch?.id ?? 0,
      );
      if (mounted) {
        setState(() {
          treatments = result;
          selectedTreatments.clear();
        });
      }
    } catch (e) {
      if (mounted) {
        showErrorMessage(e.toString());
      }
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
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
      setState(() => selectedDate = picked);
    }
  }
}
