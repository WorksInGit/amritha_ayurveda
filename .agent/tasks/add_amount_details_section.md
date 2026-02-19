# Task: Add AmountDetailsSection to RegisterScreen

## Objective
Add `AmountDetailsSection` to `RegisterScreen` as requested by the user, and ensure it's imported correctly.

## Changes
1.  **Updated `RegisterScreen`**:
    *   Added `const AmountDetailsSection()` and `gapLarge` to the `Column` in `build` method, placing it after `PaymentDetailsSection`.
    *   Added import for `widgets/amount_details_section.dart`.

## Verification
*   `AmountDetailsSection` is now part of the widget tree in `RegisterScreen`.
*   Import error is resolved.
