import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

TextStyle baseStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontFamily: "Poppins",
);

final hintStyle = baseStyle.copyWith(
  fontWeight: FontWeight.w400,
  fontSize: 13.5.fSize,
  color: const Color(0xff868686),
);

const inputborder = UnderlineInputBorder(
  borderSide: BorderSide(color: Color(0xffDBDBDB)),
);

ThemeData get themeData => ThemeData(
  scaffoldBackgroundColor: Colors.white,
  tabBarTheme: TabBarThemeData(
    unselectedLabelColor: Color(0xff101317),
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(padding * 1.4),
      gradient: LinearGradient(colors: [Color(0xffD52358), Color(0xffEC7130)]),
    ),
    dividerColor: Colors.transparent,
    labelColor: Colors.white,
    unselectedLabelStyle: baseStyle.copyWith(
      fontWeight: FontWeight.w300,
      fontSize: 14.fSize,
    ),
    labelStyle: baseStyle.copyWith(
      fontWeight: FontWeight.w300,
      fontSize: 14.fSize,
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(paddingXL)),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: baseStyle.copyWith(
      fontSize: 16.fSize,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: baseStyle.copyWith(
      fontSize: 14.fSize,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: baseStyle.copyWith(
      fontSize: 34.fSize,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: baseStyle.copyWith(
      fontSize: 26.fSize,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: baseStyle.copyWith(
      fontSize: 22.fSize,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: baseStyle.copyWith(
      fontSize: 20.fSize,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: baseStyle.copyWith(
      fontSize: 18.fSize,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: baseStyle.copyWith(
      fontSize: 16.fSize,
      fontWeight: FontWeight.w700,
    ),
    labelLarge: baseStyle.copyWith(
      fontSize: 18.fSize,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffEEEEEE)),
  listTileTheme: ListTileThemeData(titleTextStyle: baseStyle.copyWith()),
  appBarTheme: AppBarTheme(
    centerTitle: false,
    scrolledUnderElevation: 0,
    titleTextStyle: baseStyle.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 17.fSize,
      color: Color(0xff3C3F4E),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 54),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
    ),
  ),

  useMaterial3: true,
  platform: TargetPlatform.iOS,
  fontFamily: "Poppins",

  primaryColor: const Color(0xff006837),
  colorScheme: const ColorScheme.light(primary: Color(0xff006837)),

  inputDecorationTheme: InputDecorationTheme(
    // Material 3 prefers outline with subtle radius
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color(0xff006837), width: 1.5),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),

    // Material 3 default spacing (do not keep zero)
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

    // Floating label behavior matches M3 spec
    floatingLabelBehavior: FloatingLabelBehavior.auto,

    // Hint style = lower emphasis than input text
    hintStyle: TextStyle(
      color: Colors.grey.shade500,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    // Label style (unfocused)
    labelStyle: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),

    // Focused label uses primary color
    floatingLabelStyle: const TextStyle(
      color: Color(0xff006837),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),

    // Error text styling
    errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),

    // Helps achieve Material 3 filled-field feel if needed later
    isDense: false,
    alignLabelWithHint: true,
  ),
);

// inputDecorationTheme: const InputDecorationTheme(
//   border: inputborder,
//   enabledBorder: inputborder,
//   focusedBorder: inputborder,
//   contentPadding: EdgeInsets.zero,
// ),
// fontFamily: "Poppins",
// useMaterial3: true,
// platform: TargetPlatform.iOS,
// primaryColor: Color(0xff006837),
// colorScheme: const ColorScheme.light(primary: Color(0xff006837)),

extension BuildContextExtension on BuildContext {}

void setSystemOverlay() {
  if (kIsWeb) return;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}
