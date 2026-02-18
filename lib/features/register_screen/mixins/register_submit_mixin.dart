import 'package:amritha_ayurveda/core/repository.dart';
import 'package:amritha_ayurveda/mixins/form_validator_mixin.dart';
import 'package:amritha_ayurveda/services/receipt_pdf_generator.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../core/extenstion.dart';
import 'register_data_mixin.dart';

mixin RegisterSubmitMixin<T extends StatefulWidget>
    on State<T>, RegisterDataMixin<T>, FormValidatorMixin<T> {
  Future<void> submit() async {
    if (!validate()) return;

    if (selectedBranchNotifier.value == null) {
      showErrorMessage('Please select a branch');
      return;
    }
    if (selectedTreatmentsNotifier.value.isEmpty) {
      showErrorMessage('Please add at least one treatment');
      return;
    }
    if (selectedDateNotifier.value == null) {
      showErrorMessage('Please select a treatment date');
      return;
    }
    if (selectedHourNotifier.value == null ||
        selectedMinuteNotifier.value == null) {
      showErrorMessage('Please select treatment time');
      return;
    }
    if (selectedPaymentNotifier.value.isEmpty) {
      showErrorMessage('Please select a payment option');
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

      await DataRepository.i.registerPatient(
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
          // Navigator.pop(context, true);
        }
      }
    } catch (e) {
      showErrorMessage(e.toString());
    } finally {
      if (mounted) makeButtonNotLoading();
    }
  }
}
