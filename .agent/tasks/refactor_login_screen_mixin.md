# Task: Refactor LoginScreen to use EmailPasswordMixin

## Objective
Refactor `lib/features/login_screen/login_screen.dart` to use `EmailPasswordMixin` for state management and logic, addressing the user's request to "fix it" and ensuring proper token handling.

## Changes
1.  **Refactored `LoginScreen`**:
    *   Added `with EmailPasswordMixin` to `_LoginScreenState`.
    *   Removed local state variables: `isLoading`, `usernameController`, `passwordController`, `isPasswordVisible`, `_formKey`.
    *   Replaced usages with mixin equivalents: `loginButtonLoading`, `emailController`, `passwordController`, `passwordVisible`, `formKey`.
    *   Used mixin methods: `signInWithEmailAndPassword`, `togglePasswordVisibility`, `emailValidator`, `passwordValidator`.
    *   Removed unused imports (`app_route`, `home_screen`, `snackbar_utils`, `repository`).

2.  **Logic Consolidation**:
    *   Login logic including API call, token saving (via `SharedPreferencesService`), and navigation is now centralized in `EmailPasswordMixin`.
    *   This aligns with the user's change in `repository.dart` where token saving was removed.

## Verification
*   `LoginScreen` correctly imports the mixin.
*   The mixin handles form validation, API interaction, and navigation.
*   Unused code and imports are cleaned up.
