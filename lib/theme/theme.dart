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

  inputDecorationTheme: const InputDecorationTheme(
    border: inputborder,
    enabledBorder: inputborder,
    focusedBorder: inputborder,
    contentPadding: EdgeInsets.zero,
  ),
  fontFamily: "Poppins",
  useMaterial3: true,
  platform: TargetPlatform.iOS,
  primaryColor: Color(0xff006837),
  colorScheme: const ColorScheme.light(primary: Color(0xff006837)),
);

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
