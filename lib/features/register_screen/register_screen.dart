import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/mixins/form_validator_mixin.dart';
import 'package:amritha_ayurveda/models/branch_model.dart';
import 'package:amritha_ayurveda/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/widgets/app_dropdown_field.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

import 'mixins/register_data_mixin.dart';
import 'mixins/register_submit_mixin.dart';
import 'widgets/date_time_section.dart';
import 'widgets/payment_option_section.dart';
import 'widgets/treatment_section.dart';

/// A selected treatment entry with male/female counts.
class SelectedTreatment {
  final Treatment treatment;
  int maleCount;
  int femaleCount;

  SelectedTreatment({
    required this.treatment,
    this.maleCount = 1,
    this.femaleCount = 0,
  });
}

class RegisterScreen extends StatefulWidget {
  static const String path = '/register-screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with FormValidatorMixin, RegisterDataMixin, RegisterSubmitMixin {
  @override
  void initState() {
    super.initState();
    loadBranches();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoadingData
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                controller: formScrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24.fSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    gapSmall,
                    const Divider(),
                    gapLarge,

                    // --- Patient Info Fields ---
                    _buildPatientFields(),
                    gapLarge,

                    // --- Treatments Section ---
                    TreatmentSection(
                      treatments: treatments,
                      selectedTreatments: selectedTreatments,
                      onChanged: () => setState(() {}),
                    ),
                    gapLarge,

                    // --- Amount Fields ---
                    _buildAmountFields(),
                    gapLarge,

                    // --- Payment Option ---
                    PaymentOptionSection(
                      selectedPayment: selectedPayment,
                      onChanged: (val) => setState(() => selectedPayment = val),
                    ),
                    gapLarge,

                    // --- Advance & Balance ---
                    _buildAdvanceBalanceFields(),
                    gapLarge,

                    // --- Date & Time ---
                    DatePickerSection(
                      selectedDate: selectedDate,
                      onTap: () => pickDate(context),
                    ),
                    gapLarge,
                    TimePickerSection(
                      selectedHour: selectedHour,
                      selectedMinute: selectedMinute,
                      onHourChanged: (val) =>
                          setState(() => selectedHour = val),
                      onMinuteChanged: (val) =>
                          setState(() => selectedMinute = val),
                    ),

                    const SizedBox(height: 30),

                    // --- Submit Button ---
                    AppButton(
                      text: 'Save',
                      isLoading: buttonLoading,
                      onPressed: submit,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
    );
  }

  // ─── Patient Info Fields ─────────────────────────────────────────────
  Widget _buildPatientFields() {
    return Column(
      children: [
        AppTextField(
          label: 'Name',
          hintText: 'Enter your full name',
          controller: nameController,
          validator: (v) {
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
          },
        ),
        gapLarge,
        AppTextField(
          label: 'Whatsapp Number',
          hintText: 'Enter your Whatsapp number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'WhatsApp number is required';
            }
            final digits = v.trim().replaceAll(RegExp(r'[^0-9]'), '');
            if (digits.length != 10) {
              return 'Enter a valid 10-digit phone number';
            }
            return null;
          },
        ),
        gapLarge,
        AppTextField(
          label: 'Address',
          hintText: 'Enter your full address',
          controller: addressController,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Address is required';
            }
            return null;
          },
        ),
        gapLarge,
        AppDropdownField<String>(
          label: 'Location',
          hintText: 'Choose your location',
          value: selectedLocation,
          items: RegisterDataMixin.locations,
          displayText: (loc) => loc,
          onChanged: (val) => setState(() => selectedLocation = val),
        ),
        gapLarge,
        AppDropdownField<Branch>(
          label: 'Branch',
          hintText: 'Select the branch',
          value: selectedBranch,
          items: branches,
          displayText: (b) => b.name,
          onChanged: (val) {
            setState(() => selectedBranch = val);
            loadTreatments();
          },
        ),
      ],
    );
  }

  // ─── Amount Fields ───────────────────────────────────────────────────
  Widget _buildAmountFields() {
    return Column(
      children: [
        AppTextField(
          label: 'Total Amount',
          hintText: '',
          controller: totalAmountController,
          keyboardType: TextInputType.number,
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
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v != null && v.trim().isNotEmpty) {
              final discount = double.tryParse(v.trim());
              if (discount == null || discount < 0) {
                return 'Enter a valid amount';
              }
              final total =
                  double.tryParse(totalAmountController.text.trim()) ?? 0;
              if (discount > total) {
                return 'Discount cannot exceed total amount';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  // ─── Advance & Balance Fields ────────────────────────────────────────
  Widget _buildAdvanceBalanceFields() {
    return Column(
      children: [
        AppTextField(
          label: 'Advance Amount',
          hintText: '',
          controller: advanceAmountController,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v != null && v.trim().isNotEmpty) {
              final amount = double.tryParse(v.trim());
              if (amount == null || amount < 0) {
                return 'Enter a valid amount';
              }
            }
            return null;
          },
        ),
        gapLarge,
        AppTextField(
          label: 'Balance Amount',
          hintText: '',
          controller: balanceAmountController,
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v != null && v.trim().isNotEmpty) {
              final amount = double.tryParse(v.trim());
              if (amount == null || amount < 0) {
                return 'Enter a valid amount';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
