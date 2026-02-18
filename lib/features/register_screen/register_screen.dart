import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/mixins/form_validator_mixin.dart';
import 'package:amritha_ayurveda/models/treatment_model.dart';
import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:amritha_ayurveda/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/theme.dart';
import 'mixins/register_data_mixin.dart';
import 'mixins/register_submit_mixin.dart';
import 'widgets/date_time_section.dart';
import 'widgets/patient_details_section.dart';
import 'widgets/payment_details_section.dart';
import 'widgets/treatment_section.dart';
import 'widgets/register_form_scope.dart';

class RegisterScreen extends StatefulWidget {
  static const String path = '/register-screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>
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
    return RegisterFormScope(
      state: this,
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoadingDataNotifier,
        builder: (context, isLoadingData, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(backgroundColor: Colors.white),
            body: isLoadingData
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: primaryColor),
                        gapLarge,
                        Text('Loading...'),
                      ],
                    ),
                  )
                : Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      controller: formScrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapLarge,
                          Text(
                            'Register',
                            style: context.poppins60024.copyWith(
                              color: appBlackColor,
                            ),
                          ),
                          Gap(13.w),
                          const Divider(),
                          gapLarge,
                          const PatientDetailsSection(),
                          gapLarge,
                          const TreatmentSection(),
                          gapLarge,
                          const PaymentDetailsSection(),
                          gapLarge,
                          const DatePickerSection(),
                          gapLarge,
                          const TimePickerSection(),
                          gapLarge,
                          AppButton(
                            text: 'Save',
                            onPressed: submit,
                            isLoading: buttonLoading,
                          ),
                          Gap(40.w),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  void updateCalculations() {
    double totalAmount = 0;

    for (final st in selectedTreatmentsNotifier.value) {
      final price = double.tryParse(st.treatment.price ?? '0') ?? 0;
      final patientCount = st.maleCount + st.femaleCount;
      totalAmount += price * patientCount;
    }

    totalAmountController.text = totalAmount.toStringAsFixed(0);
    updateBalance();
    selectedTreatmentsNotifier.value = List.from(
      selectedTreatmentsNotifier.value,
    );
  }

  void updateBalance() {
    final total = double.tryParse(totalAmountController.text) ?? 0;
    final discount = double.tryParse(discountAmountController.text) ?? 0;
    final advance = double.tryParse(advanceAmountController.text) ?? 0;

    final balance = total - discount - advance;
    balanceAmountController.text = balance.toStringAsFixed(0);
  }
}

class SelectedTreatment {
  Treatment treatment;
  int maleCount;
  int femaleCount;

  SelectedTreatment({
    required this.treatment,
    this.maleCount = 1,
    this.femaleCount = 0,
  });
}
