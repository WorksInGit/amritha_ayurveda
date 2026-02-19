import 'package:amritha_ayurveda/core/repository.dart';
import 'package:amritha_ayurveda/features/register_screen/models/register_patient_model.dart';
import 'package:amritha_ayurveda/mixins/form_validator_mixin.dart';
import 'package:amritha_ayurveda/services/receipt_pdf_generator.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../../core/extenstion.dart';
import 'register_data_mixin.dart';
import 'package:amritha_ayurveda/features/register_screen/models/branch_model.dart';

mixin RegisterSubmitMixin<T extends StatefulWidget>
    on State<T>, RegisterDataMixin<T>, FormValidatorMixin<T> {
  Future<void> submit() async {
    if (!validate()) return;
    if (selectedTreatmentsNotifier.value.isEmpty) {
      showErrorMessage('Please add at least one treatment');
      return;
    }

    makeButtonLoading();

    try {
      final h = selectedHourNotifier.value!;
      final hour12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
      final amPm = h >= 12 ? 'PM' : 'AM';

      final dateStr = selectedDateNotifier.value.dayMonthYear;
      final timeStr =
          '${hour12.toString().padLeft(2, '0')}:${selectedMinuteNotifier.value!.toString().padLeft(2, '0')} $amPm';
      final dateAndTime = '$dateStr-$timeStr';

      final treatmentIds = selectedTreatmentsNotifier.value
          .map((st) => st.treatment.id.toString())
          .join(',');

      final maleIds = selectedTreatmentsNotifier.value
          .where((st) => st.maleCount > 0)
          .map((st) => st.treatment.id.toString())
          .join(',');

      final femaleIds = selectedTreatmentsNotifier.value
          .where((st) => st.femaleCount > 0)
          .map((st) => st.treatment.id.toString())
          .join(',');

      final patient = RegisterPatientModel(
        name: nameController.text.trim(),
        excecutive: '',
        payment: selectedPaymentNotifier.value,
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        totalAmount: totalAmountController.text.trim(),
        discountAmount: discountAmountController.text.trim(),
        advanceAmount: advanceAmountController.text.trim(),
        balanceAmount: balanceAmountController.text.trim(),
        dateAndTime: dateAndTime,
        id: '',
        male: maleIds,
        female: femaleIds,
        branch: selectedBranchNotifier.value!.id.toString(),
        treatments: treatmentIds,
      );

      await DataRepository.i.registerPatient(patient);

      if (mounted) {
        final now = DateTime.now();
        final bookedOnDate = now.dayMonthYear;
        final bookedOnTime = now.time?.toLowerCase();

        final receiptData = ReceiptData(
          patientName: nameController.text.trim(),
          address: addressController.text.trim().isNotEmpty
              ? '${addressController.text.trim()}, ${selectedLocationNotifier.value ?? ''}'
              : selectedLocationNotifier.value ?? 'N/A',
          whatsappNumber: '+91 ${phoneController.text.trim()}',
          bookedOnDate: bookedOnDate ?? "N/A",
          bookedOnTime: bookedOnTime ?? "N/A",
          treatmentDate: dateStr ?? "N/A",
          treatmentTime: timeStr.toLowerCase(),
          branch: selectedBranchNotifier.value!,
          treatments: selectedTreatmentsNotifier.value.map((st) {
            final price = double.tryParse(st.treatment.price ?? '0') ?? 0;
            final total = price * (st.maleCount + st.femaleCount);
            return ReceiptTreatmentItem(
              name: st.treatment.name ?? 'N/A',
              price: st.treatment.price ?? '0',
              maleCount: st.maleCount,
              femaleCount: st.femaleCount,
              total: total.toStringAsFixed(0),
            );
          }).toList(),
          totalAmount: totalAmountController.text.trim(),
          discountAmount: discountAmountController.text.trim(),
          advanceAmount: advanceAmountController.text.trim(),
          balanceAmount: balanceAmountController.text.trim(),
        );

        final pdfBytes = await ReceiptPdfGenerator.generate(receiptData);

        if (mounted) {
          await Printing.layoutPdf(
            onLayout: (_) => pdfBytes,
            name: 'Receipt_${nameController.text.trim()}_$bookedOnDate',
          );
        }

        if (mounted) {
          showSuccessMessage('Patient registered successfully');
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      showErrorMessage(e.toString());
    } finally {
      if (mounted) makeButtonNotLoading();
    }
  }

  String? nameValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Name is required';
    }
    if (v.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(v.trim())) {
      return 'Name should contain only letters';
    }
    return null;
  }

  String? phoneValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'WhatsApp number is required';
    }
    final digits = v.trim().replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 10) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? addressValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? locationValidator(String? val) =>
      val == null || val.isEmpty ? 'Location is required' : null;

  String? branchValidator(Branch? val) =>
      val == null ? 'Branch is required' : null;

  String? totalAmountValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Total amount is required';
    }
    final amount = double.tryParse(v.trim());
    if (amount == null || amount < 0) {
      return 'Enter a valid amount';
    }
    return null;
  }

  String? discountAmountValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Discount amount is required';
    }
    final discount = double.tryParse(v.trim());
    if (discount == null || discount < 0) {
      return 'Enter a valid amount';
    }
    final total = double.tryParse(totalAmountController.text.trim()) ?? 0;
    if (discount > total) {
      return 'Discount cannot exceed total amount';
    }
    return null;
  }

  String? paymentOptionValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please select a payment option';
    }
    return null;
  }

  String? advanceAmountValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Advance amount is required';
    }
    final amount = double.tryParse(v.trim());
    if (amount == null || amount < 0) {
      return 'Enter a valid amount';
    }
    return null;
  }

  String? balanceAmountValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Balance amount is required';
    }
    final amount = double.tryParse(v.trim());
    if (amount == null || amount < 0) {
      return 'Enter a valid amount';
    }
    return null;
  }

  String? dateValidator(DateTime? val) {
    if (val == null) {
      return 'Please select a treatment date';
    }
    return null;
  }

  String? hourValidator(int? val) {
    if (val == null) return 'Required';
    return null;
  }

  String? minuteValidator(int? val) {
    if (val == null) return 'Required';
    return null;
  }
}
