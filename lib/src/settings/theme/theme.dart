import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff675e46),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2c2511),
      onPrimaryContainer: Color(0xffbcb094),
      secondary: Color(0xff635e52),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffebe3d4),
      onSecondaryContainer: Color(0xff4d483d),
      tertiary: Color(0xff26575d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4d7c82),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffef8f4),
      onSurface: Color(0xff1d1b19),
      onSurfaceVariant: Color(0xff4b463d),
      outline: Color(0xff7c766c),
      outlineVariant: Color.fromARGB(80, 205, 198, 185), // 手動で更新
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff32302e),
      inversePrimary: Color(0xffd2c5a8),
      primaryFixed: Color(0xffefe1c3),
      onPrimaryFixed: Color(0xff211b08),
      primaryFixedDim: Color(0xffd2c5a8),
      onPrimaryFixedVariant: Color(0xff4e4630),
      secondaryFixed: Color(0xffeae1d3),
      onSecondaryFixed: Color(0xff1f1b12),
      secondaryFixedDim: Color(0xffcdc6b7),
      onSecondaryFixedVariant: Color(0xff4b463c),
      tertiaryFixed: Color(0xffbaebf2),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xff9fcfd5),
      onTertiaryFixedVariant: Color(0xff1b4d53),
      surfaceDim: Color(0xffded9d5),
      surfaceBright: Color(0xfffef8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f3ef),
      surfaceContainer: Color(0xfff2ede9),
      surfaceContainerHigh: Color(0xffece7e3),
      surfaceContainerHighest: Color(0xffe6e2de),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff675e46),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2c2511),
      onPrimaryContainer: Color(0xffe9dbbd),
      secondary: Color(0xff474238),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7a7468),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff16494f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4d7c82),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef8f4),
      onSurface: Color(0xff1d1b19),
      onSurfaceVariant: Color(0xff474239),
      outline: Color(0xff635f55),
      outlineVariant: Color(0xff807a6f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff32302e),
      inversePrimary: Color(0xffd2c5a8),
      primaryFixed: Color(0xff7e745a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff645b43),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7a7468),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff615b50),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4d7c82),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff336369),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffded9d5),
      surfaceBright: Color(0xfffef8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f3ef),
      surfaceContainer: Color(0xfff2ede9),
      surfaceContainerHigh: Color(0xffece7e3),
      surfaceContainerHighest: Color(0xffe6e2de),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff8c4a60),
      surfaceTint: Color(0xff675e46),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2c2511),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff262219),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff474238),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00272b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff16494f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef8f4),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff27241c),
      outline: Color(0xff474239),
      outlineVariant: Color(0xff474239),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff32302e),
      inversePrimary: Color(0xfff9ebcc),
      primaryFixed: Color(0xff4a422c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff332c18),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff474238),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff302c23),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff16494f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003237),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffded9d5),
      surfaceBright: Color(0xfffef8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f3ef),
      surfaceContainer: Color(0xfff2ede9),
      surfaceContainerHigh: Color(0xffece7e3),
      surfaceContainerHighest: Color(0xffe6e2de),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe3c46d),
      surfaceTint: Color(0xffd2c5a8),
      onPrimary: Color(0xff37301b),
      primaryContainer: Color(0xff140e01),
      onPrimaryContainer: Color(0xffa89c81),
      secondary: Color(0xffcdc6b7),
      onSecondary: Color(0xff343026),
      secondaryContainer: Color(0xff443f34),
      onSecondaryContainer: Color(0xffdbd3c5),
      tertiary: Color(0xff9fcfd5),
      onTertiary: Color(0xff00363b),
      tertiaryContainer: Color(0xff4d7c82),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141311),
      onSurface: Color(0xffe6e2de),
      onSurfaceVariant: Color(0xffcdc6b9),
      outline: Color(0xff969085),
      outlineVariant: Color(0xff4b463d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2de),
      inversePrimary: Color(0xff675e46),
      primaryFixed: Color(0xffefe1c3),
      onPrimaryFixed: Color(0xff211b08),
      primaryFixedDim: Color(0xffd2c5a8),
      onPrimaryFixedVariant: Color(0xff4e4630),
      secondaryFixed: Color(0xffeae1d3),
      onSecondaryFixed: Color(0xff1f1b12),
      secondaryFixedDim: Color(0xffcdc6b7),
      onSecondaryFixedVariant: Color(0xff4b463c),
      tertiaryFixed: Color(0xffbaebf2),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xff9fcfd5),
      onTertiaryFixedVariant: Color(0xff1b4d53),
      surfaceDim: Color(0xff141311),
      surfaceBright: Color(0xff3b3936),
      surfaceContainerLowest: Color(0xff0f0e0c),
      surfaceContainerLow: Color(0xff1d1b19),
      surfaceContainer: Color(0xff211f1d),
      surfaceContainerHigh: Color(0xff2b2a27),
      surfaceContainerHighest: Color(0xff363432),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe2c46d),
      surfaceTint: Color(0xffd2c5a8),
      onPrimary: Color(0xff1c1604),
      primaryContainer: Color(0xff9b9075),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd2cabc),
      onSecondary: Color(0xff19160d),
      secondaryContainer: Color(0xff979083),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa3d3d9),
      onTertiary: Color(0xff001a1d),
      tertiaryContainer: Color(0xff69989f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141311),
      onSurface: Color(0xfffffaf6),
      onSurfaceVariant: Color(0xffd1cabe),
      outline: Color(0xffa9a297),
      outlineVariant: Color(0xff888278),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2de),
      inversePrimary: Color(0xff504731),
      primaryFixed: Color(0xffefe1c3),
      onPrimaryFixed: Color(0xff161102),
      primaryFixedDim: Color(0xffd2c5a8),
      onPrimaryFixedVariant: Color(0xff3d3520),
      secondaryFixed: Color(0xffeae1d3),
      onSecondaryFixed: Color(0xff141109),
      secondaryFixedDim: Color(0xffcdc6b7),
      onSecondaryFixedVariant: Color(0xff3a362c),
      tertiaryFixed: Color(0xffbaebf2),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xff9fcfd5),
      onTertiaryFixedVariant: Color(0xff023d42),
      surfaceDim: Color(0xff141311),
      surfaceBright: Color(0xff3b3936),
      surfaceContainerLowest: Color(0xff0f0e0c),
      surfaceContainerLow: Color(0xff1d1b19),
      surfaceContainer: Color(0xff211f1d),
      surfaceContainerHigh: Color(0xff2b2a27),
      surfaceContainerHighest: Color(0xff363432),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdcc66e),
      surfaceTint: Color(0xffd2c5a8),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffd7caac),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd2cabc),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0fdff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa3d3d9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141311),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffffaf6),
      outline: Color(0xffd1cabe),
      outlineVariant: Color(0xffd1cabe),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e2de),
      inversePrimary: Color(0xff302915),
      primaryFixed: Color(0xfff3e6c7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffd7caac),
      onPrimaryFixedVariant: Color(0xff1c1604),
      secondaryFixed: Color(0xffeee6d7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd2cabc),
      onSecondaryFixedVariant: Color(0xff19160d),
      tertiaryFixed: Color(0xffbeeff6),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa3d3d9),
      onTertiaryFixedVariant: Color(0xff001a1d),
      surfaceDim: Color(0xff141311),
      surfaceBright: Color(0xff3b3936),
      surfaceContainerLowest: Color(0xff0f0e0c),
      surfaceContainerLow: Color(0xff1d1b19),
      surfaceContainer: Color(0xff211f1d),
      surfaceContainerHigh: Color(0xff2b2a27),
      surfaceContainerHighest: Color(0xff363432),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colorScheme.surface,
        ),
      );

  /// Orange
  static const orange = ExtendedColor(
    seed: Color(0xffd36c36),
    value: Color(0xffd36c36),
    light: ColorFamily(
      color: Color(0xff9a410b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb95924),
      onColorContainer: Color(0xfffffbff),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff9a410b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb95924),
      onColorContainer: Color(0xfffffbff),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff9a410b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb95924),
      onColorContainer: Color(0xfffffbff),
    ),
    dark: ColorFamily(
      color: Color(0xffffb694),
      onColor: Color(0xff561f00),
      colorContainer: Color(0xffdd743d),
      onColorContainer: Color(0xff3f1400),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb694),
      onColor: Color(0xff561f00),
      colorContainer: Color(0xffdd743d),
      onColorContainer: Color(0xff3f1400),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb694),
      onColor: Color(0xff561f00),
      colorContainer: Color(0xffdd743d),
      onColorContainer: Color(0xff3f1400),
    ),
  );

  /// Blue
  static const blue = ExtendedColor(
    seed: Color(0xff54a2a3),
    value: Color(0xff54a2a3),
    light: ColorFamily(
      color: Color(0xff08696a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff54a2a3),
      onColorContainer: Color(0xff003535),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff08696a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff54a2a3),
      onColorContainer: Color(0xff003535),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff08696a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff54a2a3),
      onColorContainer: Color(0xff003535),
    ),
    dark: ColorFamily(
      color: Color(0xff86d4d4),
      onColor: Color(0xff003737),
      colorContainer: Color(0xff54a2a3),
      onColorContainer: Color(0xff003535),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff86d4d4),
      onColor: Color(0xff003737),
      colorContainer: Color(0xff54a2a3),
      onColorContainer: Color(0xff003535),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff86d4d4),
      onColor: Color(0xff003737),
      colorContainer: Color(0xff54a2a3),
      onColorContainer: Color(0xff003535),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        orange,
        blue,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
