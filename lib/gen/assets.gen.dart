// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// Directory path: assets/fonts/poppins
  $AssetsFontsPoppinsGen get poppins => const $AssetsFontsPoppinsGen();
}

class $AssetsPngsGen {
  const $AssetsPngsGen();

  /// File path: assets/pngs/login-top-background.png
  AssetGenImage get loginTopBackground =>
      const AssetGenImage('assets/pngs/login-top-background.png');

  /// File path: assets/pngs/logo-background.png
  AssetGenImage get logoBackground =>
      const AssetGenImage('assets/pngs/logo-background.png');

  /// File path: assets/pngs/splash-background.png
  AssetGenImage get splashBackground =>
      const AssetGenImage('assets/pngs/splash-background.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    loginTopBackground,
    logoBackground,
    splashBackground,
  ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/signature.svg
  String get signature => 'assets/svgs/signature.svg';

  /// File path: assets/svgs/splash-logo.svg
  String get splashLogo => 'assets/svgs/splash-logo.svg';

  /// List of all assets
  List<String> get values => [signature, splashLogo];
}

class $AssetsFontsPoppinsGen {
  const $AssetsFontsPoppinsGen();

  /// File path: assets/fonts/poppins/Poppins-Black.ttf
  String get poppinsBlack => 'assets/fonts/poppins/Poppins-Black.ttf';

  /// File path: assets/fonts/poppins/Poppins-Bold.ttf
  String get poppinsBold => 'assets/fonts/poppins/Poppins-Bold.ttf';

  /// File path: assets/fonts/poppins/Poppins-ExtraBold.ttf
  String get poppinsExtraBold => 'assets/fonts/poppins/Poppins-ExtraBold.ttf';

  /// File path: assets/fonts/poppins/Poppins-ExtraLight.ttf
  String get poppinsExtraLight => 'assets/fonts/poppins/Poppins-ExtraLight.ttf';

  /// File path: assets/fonts/poppins/Poppins-Light.ttf
  String get poppinsLight => 'assets/fonts/poppins/Poppins-Light.ttf';

  /// File path: assets/fonts/poppins/Poppins-Medium.ttf
  String get poppinsMedium => 'assets/fonts/poppins/Poppins-Medium.ttf';

  /// File path: assets/fonts/poppins/Poppins-Regular.ttf
  String get poppinsRegular => 'assets/fonts/poppins/Poppins-Regular.ttf';

  /// File path: assets/fonts/poppins/Poppins-SemiBold.ttf
  String get poppinsSemiBold => 'assets/fonts/poppins/Poppins-SemiBold.ttf';

  /// File path: assets/fonts/poppins/Poppins-Thin.ttf
  String get poppinsThin => 'assets/fonts/poppins/Poppins-Thin.ttf';

  /// List of all assets
  List<String> get values => [
    poppinsBlack,
    poppinsBold,
    poppinsExtraBold,
    poppinsExtraLight,
    poppinsLight,
    poppinsMedium,
    poppinsRegular,
    poppinsSemiBold,
    poppinsThin,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsPngsGen pngs = $AssetsPngsGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
