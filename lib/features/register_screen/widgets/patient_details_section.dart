import 'package:amritha_ayurveda/constants.dart';
import 'package:amritha_ayurveda/models/branch_model.dart';
import 'package:amritha_ayurveda/widgets/app_dropdown_field.dart';
import 'package:amritha_ayurveda/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../mixins/register_data_mixin.dart';

class PatientDetailsSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final String? selectedLocation;
  final Branch? selectedBranch;
  final List<Branch> branches;
  final ValueChanged<String?> onLocationChanged;
  final ValueChanged<Branch?> onBranchChanged;

  const PatientDetailsSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.selectedLocation,
    required this.selectedBranch,
    required this.branches,
    required this.onLocationChanged,
    required this.onBranchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
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
          onChanged: onLocationChanged,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Location is required';
            }
            return null;
          },
        ),
        gapLarge,
        AppDropdownField<Branch>(
          label: 'Branch',
          hintText: 'Select the branch',
          value: selectedBranch,
          items: branches,
          displayText: (b) => b.name,
          onChanged: onBranchChanged,
          validator: (val) {
            if (val == null) {
              return 'Branch is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
