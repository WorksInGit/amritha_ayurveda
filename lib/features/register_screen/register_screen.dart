import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/mixins/form_validator_mixin.dart';
import 'package:amritha_ayurveda/models/treatment_model.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:flutter/material.dart';

import 'mixins/register_data_mixin.dart';
import 'mixins/register_submit_mixin.dart';
import 'widgets/amount_details_section.dart';
import 'widgets/date_time_section.dart';
import 'widgets/patient_details_section.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
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
                      gapLarge,
                      PatientDetailsSection(
                        nameController: nameController,
                        phoneController: phoneController,
                        addressController: addressController,
                        selectedLocation: selectedLocation,
                        selectedBranch: selectedBranch,
                        branches: branches,
                        onLocationChanged: (val) =>
                            setState(() => selectedLocation = val),
                        onBranchChanged: (val) {
                          setState(() => selectedBranch = val);
                          loadTreatments();
                        },
                      ),
                      gapLarge,
                      FormField<List<SelectedTreatment>>(
                        initialValue: selectedTreatments,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (selectedTreatments.isEmpty) {
                            return 'Please select at least one treatment';
                          }
                          return null;
                        },
                        builder: (state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TreatmentSection(
                                treatments: treatments,
                                selectedTreatments: selectedTreatments,
                                onChanged: () {
                                  setState(() {});
                                  state.didChange(selectedTreatments);
                                },
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 12,
                                  ),
                                  child: Text(
                                    state.errorText!,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                      fontSize: 12.fSize,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      gapLarge,
                      AmountDetailsSection(
                        totalAmountController: totalAmountController,
                        discountAmountController: discountAmountController,
                        advanceAmountController: advanceAmountController,
                        balanceAmountController: balanceAmountController,
                      ),
                      gapLarge,
                      PaymentOptionSection(
                        selectedPayment: selectedPayment,
                        onChanged: (val) =>
                            setState(() => selectedPayment = val),
                      ),
                      gapLarge,
                      DatePickerSection(
                        key: ValueKey(selectedDate),
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
                      gapXL,
                      AppButton(
                        text: 'Save',
                        isLoading: buttonLoading,
                        onPressed: submit,
                      ),
                      gapXL,
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
