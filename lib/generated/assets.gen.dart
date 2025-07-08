/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsGoogleFontsGen {
  const $AssetsGoogleFontsGen();

  /// File path: assets/google_fonts/AmaticSC-Regular.ttf
  String get amaticSCRegular => 'assets/google_fonts/AmaticSC-Regular.ttf';

  /// File path: assets/google_fonts/BodoniModa-Regular.ttf
  String get bodoniModaRegular => 'assets/google_fonts/BodoniModa-Regular.ttf';

  /// File path: assets/google_fonts/MPLUS1p-Regular.ttf
  String get mPLUS1pRegular => 'assets/google_fonts/MPLUS1p-Regular.ttf';

  /// File path: assets/google_fonts/NotoSansJP-Regular.ttf
  String get notoSansJPRegular => 'assets/google_fonts/NotoSansJP-Regular.ttf';

  /// File path: assets/google_fonts/Roboto-Medium.ttf
  String get robotoMedium => 'assets/google_fonts/Roboto-Medium.ttf';

  /// File path: assets/google_fonts/Roboto-Regular.ttf
  String get robotoRegular => 'assets/google_fonts/Roboto-Regular.ttf';

  /// File path: assets/google_fonts/ZenOldMincho-Regular.ttf
  String get zenOldMinchoRegular =>
      'assets/google_fonts/ZenOldMincho-Regular.ttf';

  /// List of all assets
  List<String> get values => [
        amaticSCRegular,
        bodoniModaRegular,
        mPLUS1pRegular,
        notoSansJPRegular,
        robotoMedium,
        robotoRegular,
        zenOldMinchoRegular
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/database_select.png
  AssetGenImage get databaseSelect =>
      const AssetGenImage('assets/images/database_select.png');

  /// File path: assets/images/illust_complete.png
  AssetGenImage get illustComplete =>
      const AssetGenImage('assets/images/illust_complete.png');

  /// File path: assets/images/illust_standup.png
  AssetGenImage get illustStandup =>
      const AssetGenImage('assets/images/illust_standup.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [databaseSelect, illustComplete, illustStandup];
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// File path: assets/sounds/complete.mp3
  String get complete => 'assets/sounds/complete.mp3';

  /// List of all assets
  List<String> get values => [complete];
}

class Assets {
  const Assets._();

  static const $AssetsGoogleFontsGen googleFonts = $AssetsGoogleFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
