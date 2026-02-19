# Task: Replace setState with ValueNotifier in HomeScreen

## Objective
Replace `setState` with `ValueNotifier` in `lib/features/home_screen/home_screen.dart` to improve state management efficiency and separate UI rebuilding logic.

## Changes
1.  **Refactored `_HomeScreenState`**:
    *   Replaced `double downloadProgress` with `ValueNotifier<double> downloadProgressNotifier`.
    *   Replaced `Future<List<Patient>>? patientListFuture` with `ValueNotifier<Future<List<Patient>>?> patientListFutureNotifier`.
    *   Updated `initState` to initialize notifiers and call `getData`.
    *   Updated `dispose` to dispose notifiers and cancel timer.
    *   Updated `startSimulatedProgress` to update `downloadProgressNotifier.value` directly without `setState`.
    *   Updated `getData` to update `patientListFutureNotifier.value` and `downloadProgressNotifier.value` directly without `setState`.

2.  **Updated `build` method**:
    *   Wrapped `AppBar` actions `Visibility` with `ValueListenableBuilder<double>`.
    *   Wrapped `body` with nested `ValueListenableBuilder`s for `patientListFutureNotifier` and `downloadProgressNotifier`.
    *   Wrapped `bottomNavigationBar` `Visibility` with `ValueListenableBuilder<double>`.

## Rationale
Using `ValueNotifier` allows for more granular rebuilding of the widget tree. `setState` rebuilds the entire `HomeScreen` widget, whereas `ValueListenableBuilder` only rebuilds its children when the specific value changes. This improves performance and code organization.
