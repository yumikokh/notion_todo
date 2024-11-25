import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278190080),
      surfaceTint: Color(4284964422),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281083153),
      onPrimaryContainer: Color(4290556052),
      secondary: Color(4284702290),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293649364),
      onSecondaryContainer: Color(4283254845),
      tertiary: Color(4280702813),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283268226),
      onTertiaryContainer: Color(4294967295),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294899956),
      onBackground: Color(4280097561),
      surface: Color(4294899956),
      onSurface: Color(4280097561),
      surfaceVariant: Color(4293518037),
      onSurfaceVariant: Color(4283123261),
      outline: Color(4286346860),
      outlineVariant: Color(4291675833),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281479214),
      inverseOnSurface: Color(4294308076),
      inversePrimary: Color(4292003240),
      primaryFixed: Color(4293910979),
      onPrimaryFixed: Color(4280359688),
      primaryFixedDim: Color(4292003240),
      onPrimaryFixedVariant: Color(4283319856),
      secondaryFixed: Color(4293583315),
      onSecondaryFixed: Color(4280228626),
      secondaryFixedDim: Color(4291675831),
      onSecondaryFixedVariant: Color(4283123260),
      tertiaryFixed: Color(4290440178),
      onTertiaryFixed: Color(4278198051),
      tertiaryFixedDim: Color(4288663509),
      onTertiaryFixedVariant: Color(4279979347),
      surfaceDim: Color(4292794837),
      surfaceBright: Color(4294899956),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294505455),
      surfaceContainer: Color(4294110697),
      surfaceContainerHigh: Color(4293715939),
      surfaceContainerHighest: Color(4293321438),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278190080),
      surfaceTint: Color(4284964422),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281083153),
      onPrimaryContainer: Color(4293516221),
      secondary: Color(4282860088),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4286215272),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279650639),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283268226),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294899956),
      onBackground: Color(4280097561),
      surface: Color(4294899956),
      onSurface: Color(4280097561),
      surfaceVariant: Color(4293518037),
      onSurfaceVariant: Color(4282860089),
      outline: Color(4284702549),
      outlineVariant: Color(4286610031),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281479214),
      inverseOnSurface: Color(4294308076),
      inversePrimary: Color(4292003240),
      primaryFixed: Color(4286477402),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284767043),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4286215272),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284570448),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283268226),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281557865),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292794837),
      surfaceBright: Color(4294899956),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294505455),
      surfaceContainer: Color(4294110697),
      surfaceContainerHigh: Color(4293715939),
      surfaceContainerHighest: Color(4293321438),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278190080),
      surfaceTint: Color(4284964422),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281083153),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280689177),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282860088),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200107),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4279650639),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294899956),
      onBackground: Color(4280097561),
      surface: Color(4294899956),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293518037),
      onSurfaceVariant: Color(4280755228),
      outline: Color(4282860089),
      outlineVariant: Color(4282860089),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281479214),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294568908),
      primaryFixed: Color(4283056684),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281543704),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282860088),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281347107),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4279650639),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202935),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292794837),
      surfaceBright: Color(4294899956),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294505455),
      surfaceContainer: Color(4294110697),
      surfaceContainerHigh: Color(4293715939),
      surfaceContainerHighest: Color(4293321438),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292003240),
      surfaceTint: Color(4292003240),
      onPrimary: Color(4281806875),
      primaryContainer: Color(4279504385),
      onPrimaryContainer: Color(4289240193),
      secondary: Color(4291675831),
      onSecondary: Color(4281610278),
      secondaryContainer: Color(4282662708),
      onSecondaryContainer: Color(4292596677),
      tertiary: Color(4288663509),
      onTertiary: Color(4278203963),
      tertiaryContainer: Color(4283268226),
      onTertiaryContainer: Color(4294967295),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279505681),
      onBackground: Color(4293321438),
      surface: Color(4279505681),
      onSurface: Color(4293321438),
      surfaceVariant: Color(4283123261),
      onSurfaceVariant: Color(4291675833),
      outline: Color(4288057477),
      outlineVariant: Color(4283123261),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321438),
      inverseOnSurface: Color(4281479214),
      inversePrimary: Color(4284964422),
      primaryFixed: Color(4293910979),
      onPrimaryFixed: Color(4280359688),
      primaryFixedDim: Color(4292003240),
      onPrimaryFixedVariant: Color(4283319856),
      secondaryFixed: Color(4293583315),
      onSecondaryFixed: Color(4280228626),
      secondaryFixedDim: Color(4291675831),
      onSecondaryFixedVariant: Color(4283123260),
      tertiaryFixed: Color(4290440178),
      onTertiaryFixed: Color(4278198051),
      tertiaryFixedDim: Color(4288663509),
      onTertiaryFixedVariant: Color(4279979347),
      surfaceDim: Color(4279505681),
      surfaceBright: Color(4282071350),
      surfaceContainerLowest: Color(4279176716),
      surfaceContainerLow: Color(4280097561),
      surfaceContainer: Color(4280360733),
      surfaceContainerHigh: Color(4281018919),
      surfaceContainerHighest: Color(4281742386),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292332204),
      surfaceTint: Color(4292003240),
      onPrimary: Color(4280030724),
      primaryContainer: Color(4288385141),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4292004540),
      onSecondary: Color(4279834125),
      secondaryContainer: Color(4288123011),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4288926681),
      onTertiary: Color(4278196765),
      tertiaryContainer: Color(4285110431),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279505681),
      onBackground: Color(4293321438),
      surface: Color(4279505681),
      onSurface: Color(4294966006),
      surfaceVariant: Color(4283123261),
      onSurfaceVariant: Color(4291939006),
      outline: Color(4289307287),
      outlineVariant: Color(4287136376),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321438),
      inverseOnSurface: Color(4281018919),
      inversePrimary: Color(4283451185),
      primaryFixed: Color(4293910979),
      onPrimaryFixed: Color(4279636226),
      primaryFixedDim: Color(4292003240),
      onPrimaryFixedVariant: Color(4282201376),
      secondaryFixed: Color(4293583315),
      onSecondaryFixed: Color(4279505161),
      secondaryFixedDim: Color(4291675831),
      onSecondaryFixedVariant: Color(4282005036),
      tertiaryFixed: Color(4290440178),
      onTertiaryFixed: Color(4278195223),
      tertiaryFixedDim: Color(4288663509),
      onTertiaryFixedVariant: Color(4278336834),
      surfaceDim: Color(4279505681),
      surfaceBright: Color(4282071350),
      surfaceContainerLowest: Color(4279176716),
      surfaceContainerLow: Color(4280097561),
      surfaceContainer: Color(4280360733),
      surfaceContainerHigh: Color(4281018919),
      surfaceContainerHighest: Color(4281742386),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294966006),
      surfaceTint: Color(4292003240),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292332204),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294966006),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4292004540),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293983743),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4288926681),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279505681),
      onBackground: Color(4293321438),
      surface: Color(4279505681),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283123261),
      onSurfaceVariant: Color(4294966006),
      outline: Color(4291939006),
      outlineVariant: Color(4291939006),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293321438),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4281346325),
      primaryFixed: Color(4294174407),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292332204),
      onPrimaryFixedVariant: Color(4280030724),
      secondaryFixed: Color(4293846743),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4292004540),
      onSecondaryFixedVariant: Color(4279834125),
      tertiaryFixed: Color(4290703350),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4288926681),
      onTertiaryFixedVariant: Color(4278196765),
      surfaceDim: Color(4279505681),
      surfaceBright: Color(4282071350),
      surfaceContainerLowest: Color(4279176716),
      surfaceContainerLow: Color(4280097561),
      surfaceContainer: Color(4280360733),
      surfaceContainerHigh: Color(4281018919),
      surfaceContainerHighest: Color(4281742386),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// Orange
  static const orange = ExtendedColor(
    seed: Color(4292045878),
    value: Color(4292045878),
    light: ColorFamily(
      color: Color(4287247872),
      onColor: Color(4294967295),
      colorContainer: Color(4290337060),
      onColorContainer: Color(4294967295),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4287247872),
      onColor: Color(4294967295),
      colorContainer: Color(4290337060),
      onColorContainer: Color(4294967295),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4287247872),
      onColor: Color(4294967295),
      colorContainer: Color(4290337060),
      onColorContainer: Color(4294967295),
    ),
    dark: ColorFamily(
      color: Color(4294948500),
      onColor: Color(4283834112),
      colorContainer: Color(4290337060),
      onColorContainer: Color(4294967295),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294948500),
      onColor: Color(4283834112),
      colorContainer: Color(4290337060),
      onColorContainer: Color(4294967295),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294948500),
      onColor: Color(4283834112),
      colorContainer: Color(4290337060),
      onColorContainer: Color(4294967295),
    ),
  );

  /// Blue
  static const blue = ExtendedColor(
    seed: Color(4283736739),
    value: Color(4283736739),
    light: ColorFamily(
      color: Color(4278741354),
      onColor: Color(4294967295),
      colorContainer: Color(4284592048),
      onColorContainer: Color(4278196763),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4278741354),
      onColor: Color(4294967295),
      colorContainer: Color(4284592048),
      onColorContainer: Color(4278196763),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4278741354),
      onColor: Color(4294967295),
      colorContainer: Color(4284592048),
      onColorContainer: Color(4278196763),
    ),
    dark: ColorFamily(
      color: Color(4287026388),
      onColor: Color(4278204215),
      colorContainer: Color(4281237633),
      onColorContainer: Color(4294967295),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4287026388),
      onColor: Color(4278204215),
      colorContainer: Color(4281237633),
      onColorContainer: Color(4294967295),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4287026388),
      onColor: Color(4278204215),
      colorContainer: Color(4281237633),
      onColorContainer: Color(4294967295),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    orange,
    blue,
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
