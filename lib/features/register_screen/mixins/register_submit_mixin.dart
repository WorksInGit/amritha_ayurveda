import 'package:amritha_ayurveda/core/repository.dart';
import 'package:amritha_ayurveda/mixins/form_validator_mixin.dart';
import 'package:amritha_ayurveda/services/receipt_pdf_generator.dart';
import 'package:amritha_ayurveda/services/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

import 'register_data_mixin.dart';

/// Mixin that handles the form submission logic, validation checks,
/// API call, and PDF receipt generation.
mixin RegisterSubmitMixin<T extends StatefulWidget>
    on State<T>, RegisterDataMixin<T>, FormValidatorMixin<T> {
  Future<void> submit() async {
    if (!validate()) return;

    if (selectedBranch == null) {
      showErrorMessage('Please select a branch');
      return;
    }
    if (selectedTreatments.isEmpty) {
      showErrorMessage('Please add at least one treatment');
      return;
    }
    if (selectedDate == null) {
      showErrorMessage('Please select a treatment date');
      return;
    }
    if (selectedHour == null || selectedMinute == null) {
      showErrorMessage('Please select treatment time');
      return;
    }

    makeButtonLoading();

    try {
      // Format date and time: "01/02/2024-10:24 AM"
      final hour12 = selectedHour! > 12 ? selectedHour! - 12 : selectedHour!;
      final amPm = selectedHour! >= 12 ? 'PM' : 'AM';
      final dateStr = DateFormat('dd/MM/yyyy').format(selectedDate!);
      final timeStr =
          '${hour12.toString().padLeft(2, '0')}:${selectedMinute!.toString().padLeft(2, '0')} $amPm';
      final dateAndTime = '$dateStr-$timeStr';

      // Build comma-separated treatment IDs
      final treatmentIds = selectedTreatments
          .map((st) => st.treatment.id.toString())
          .join(',');

      // Build comma-separated male treatment IDs
      final maleIds = selectedTreatments
          .where((st) => st.maleCount > 0)
          .map((st) => st.treatment.id.toString())
          .join(',');

      // Build comma-separated female treatment IDs
      final femaleIds = selectedTreatments
          .where((st) => st.femaleCount > 0)
          .map((st) => st.treatment.id.toString())
          .join(',');

      await DataRepository.i.registerPatient(
        name: nameController.text.trim(),
        excecutive: '',
        payment: selectedPayment,
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
        branch: selectedBranch!.id.toString(),
        treatments: treatmentIds,
      );

      if (mounted) {
        // Generate PDF receipt
        final now = DateTime.now();
        final bookedOnDate = DateFormat('dd/MM/yyyy').format(now);
        final bookedOnTime = DateFormat('hh:mma').format(now).toLowerCase();

        final receiptData = ReceiptData(
          patientName: nameController.text.trim(),
          address: addressController.text.trim().isNotEmpty
              ? '${addressController.text.trim()}, ${selectedLocation ?? ''}'
              : selectedLocation ?? '',
          whatsappNumber: '+91 ${phoneController.text.trim()}',
          bookedOnDate: bookedOnDate,
          bookedOnTime: bookedOnTime,
          treatmentDate: dateStr,
          treatmentTime: timeStr.toLowerCase(),
          branch: selectedBranch!,
          treatments: selectedTreatments.map((st) {
            final price = double.tryParse(st.treatment.price) ?? 0;
            final total = price * (st.maleCount + st.femaleCount);
            return ReceiptTreatmentItem(
              name: st.treatment.name,
              price: st.treatment.price,
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
}
