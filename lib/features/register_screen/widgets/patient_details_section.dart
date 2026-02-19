import 'package:amritha_ayurveda/core/constants.dart';
import 'package:amritha_ayurveda/features/register_screen/mixins/register_data_mixin.dart';
import 'package:amritha_ayurveda/features/register_screen/models/branch_model.dart';

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
          validator: state.nameValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Whatsapp Number',
          hintText: 'Enter your Whatsapp number',
          controller: state.phoneController,
          keyboardType: TextInputType.phone,
          validator: state.phoneValidator,
        ),
        gapLarge,
        AppTextField(
          label: 'Address',
          hintText: 'Enter your full address',
          controller: state.addressController,
          validator: state.addressValidator,
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
              validator: state.locationValidator,
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
                  displayText: (b) => b.name ?? "N/A",
                  onChanged: (val) {
                    state.selectedBranchNotifier.value = val;
                    state.loadTreatments();
                  },
                  validator: state.branchValidator,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
