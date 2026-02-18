import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/features/register_screen/mixins/register_data_mixin.dart';
import 'package:amritha_ayurveda/models/branch_model.dart';

import 'package:amritha_ayurveda/widgets/app_dropdown_field.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'register_form_scope.dart';

class PatientDetailsSection extends StatelessWidget {
  const PatientDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = RegisterFormScope.of(context);

    return Column(
      children: [
        AppTextField(
          label: 'Name',
          hintText: 'Enter your full name',
          controller: state.nameController,
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
          controller: state.phoneController,
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
          controller: state.addressController,
          validator: (v) {
            if (v == null || v.trim().isEmpty) {
              return 'Address is required';
            }
            return null;
          },
        ),
        gapLarge,
        ValueListenableBuilder<String?>(
          valueListenable: state.selectedLocationNotifier,
          builder: (context, selectedLocation, _) {
            return AppDropdownField<String>(
              label: 'Location',
              hintText: 'Choose your location',
              value: selectedLocation,
              items: RegisterDataMixin.locations,
              displayText: (loc) => loc,
              onChanged: (val) {
                state.selectedLocationNotifier.value = val;
              },
              validator: (val) =>
                  val == null || val.isEmpty ? 'Location is required' : null,
            );
          },
        ),
        gapLarge,
        ValueListenableBuilder<List<Branch>>(
          valueListenable: state.branchesNotifier,
          builder: (context, branches, _) {
            return ValueListenableBuilder<Branch?>(
              valueListenable: state.selectedBranchNotifier,
              builder: (context, selectedBranch, _) {
                return AppDropdownField<Branch>(
                  label: 'Branch',
                  hintText: 'Select the branch',
                  value: selectedBranch,
                  items: branches,
                  displayText: (b) => b.name,
                  onChanged: (val) {
                    state.selectedBranchNotifier.value = val;
                    state.loadTreatments();
                  },
                  validator: (val) => val == null ? 'Branch is required' : null,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
