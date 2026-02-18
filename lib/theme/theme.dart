import 'package:amritha_ayurveda/services/size_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants.dart';

TextStyle baseStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontFamily: "Poppins",
);

final hintStyle = baseStyle.copyWith(
  fontWeight: FontWeight.w300,
  fontSize: 14.fSize,
  color: Colors.black.withValues(alpha: 0.4),
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
  dividerTheme: DividerThemeData(color: Colors.black.withValues(alpha: 0.2)),
  listTileTheme: ListTileThemeData(titleTextStyle: baseStyle.copyWith()),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Color(0xff006837),
    centerTitle: true,
    titleTextStyle: baseStyle.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 17.fSize,
      color: Colors.white,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: const Color(0xFF006837),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      disabledBackgroundColor: const Color(0xFF006837).withValues(alpha: 0.6),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: Color(0x40D9D9D9),
    focusColor: Color(0x40D9D9D9),
    errorStyle: baseStyle.copyWith(color: Colors.red),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF006837)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
    ),
    hintStyle: baseStyle.copyWith(
      fontWeight: FontWeight.w300,
      fontSize: 14.fSize,
      color: Colors.black.withValues(alpha: 0.4),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: paddingLarge,
      vertical: paddingLarge,
    ),
  ),
  fontFamily: "Poppins",
  useMaterial3: true,
  platform: TargetPlatform.iOS,
  primaryColor: Color(0xff006837),
  colorScheme: const ColorScheme.light(primary: Color(0xff006837)),
);

extension BuildContextExtension on BuildContext {
  TextStyle get poppins60024 =>
      baseStyle.copyWith(fontSize: 24.fSize, fontWeight: FontWeight.w600);

  TextStyle get poppins40016 =>
      baseStyle.copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w400);

  TextStyle get poppins30014 =>
      baseStyle.copyWith(fontSize: 14.fSize, fontWeight: FontWeight.w300);

  TextStyle get poppins30012 =>
      baseStyle.copyWith(fontSize: 12.fSize, fontWeight: FontWeight.w300);

  TextStyle get poppins50012 =>
      baseStyle.copyWith(fontSize: 12.fSize, fontWeight: FontWeight.w500);

  TextStyle get poppins60017 =>
      baseStyle.copyWith(fontSize: 17.fSize, fontWeight: FontWeight.w600);

  TextStyle get poppins50018 =>
      baseStyle.copyWith(fontSize: 18.fSize, fontWeight: FontWeight.w500);
  TextStyle get poppins30016 =>
      baseStyle.copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w300);
  TextStyle get poppins40015 =>
      baseStyle.copyWith(fontSize: 15.fSize, fontWeight: FontWeight.w400);

  TextStyle get poppins50016 =>
      baseStyle.copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w500);

  TextStyle get poppins60018 =>
      baseStyle.copyWith(fontSize: 18.fSize, fontWeight: FontWeight.w600);

  TextStyle get poppins40014 =>
      baseStyle.copyWith(fontSize: 14.fSize, fontWeight: FontWeight.w400);

  TextStyle get poppins60014 =>
      baseStyle.copyWith(fontSize: 14.fSize, fontWeight: FontWeight.w600);

  TextStyle get poppins40012 =>
      baseStyle.copyWith(fontSize: 12.fSize, fontWeight: FontWeight.w400);

  TextStyle get poppins60016 =>
      baseStyle.copyWith(fontSize: 16.fSize, fontWeight: FontWeight.w600);

  TextStyle get poppins50014 =>
      baseStyle.copyWith(fontSize: 14.fSize, fontWeight: FontWeight.w500);
}

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
