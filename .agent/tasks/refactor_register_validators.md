# Task: Refactor RegisterScreen Validators to RegisterSubmitMixin

## Objective
Refactor validators in `RegisterScreen` to be part of `RegisterSubmitMixin` and remove `RegisterValidatorsMixin` as requested by the user.

## Changes
1.  **Refactored `RegisterSubmitMixin`**:
    *   Added all validator methods (`nameValidator`, `phoneValidator`, `addressValidator`, etc.) to `lib/features/register_screen/mixins/register_submit_mixin.dart`.
    *   Added import `package:amritha_ayurveda/models/branch_model.dart` for `Branch` model usage.
    *   This centralizes submission and validation logic.

2.  **Cleaned up `RegisterScreen`**:
    *   Removed `RegisterValidatorsMixin` from `RegisterScreenState` mixins.
    *   Removed `RegisterValidatorsMixin` import.

3.  **Deleted `RegisterValidatorsMixin`**:
    *   Removed `lib/features/register_screen/mixins/register_validators_mixin.dart` as it's no longer needed.

4.  **Updated Widgets**:
    *   Updated `PatientDetailsSection` to use `state.nameValidator`, `state.phoneValidator`, etc.
    *   Updated `PaymentDetailsSection` to use `state.totalAmountValidator`, etc.
    *   Updated `DatePickerSection` and `TimePickerSection` to use `state.dateValidator`, `state.hourValidator`, etc.

## Verification
*   `RegisterScreen` compiles without `RegisterValidatorsMixin`.
*   Validation logic is now accessed via `state` which accesses `RegisterSubmitMixin` methods.
*   User feedback "I don't think we need a seperate file for mixin we can include in the submit mixin." has been addressed.
