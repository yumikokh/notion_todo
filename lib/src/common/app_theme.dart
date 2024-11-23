import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.0.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///  theme: AppTheme.light,
///  darkTheme: AppTheme.dark,
///  :
/// );
sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.blackWhite,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 22,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 1.0,
    lightIsWhite: true,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 21,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.tertiary,
      popupMenuRadius: 6.0,
      popupMenuElevation: 4.0,
      alignedDropdown: true,
      dialogElevation: 3.0,
      dialogRadius: 20.0,
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomSheetRadius: 20.0,
      bottomSheetElevation: 2.0,
      bottomSheetModalElevation: 3.0,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
      menuRadius: 6.0,
      menuElevation: 4.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      searchBarElevation: 3.0,
      searchViewElevation: 3.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.surface,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarBackgroundSchemeColor: SchemeColor.surface,
      navigationBarElevation: 1.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.surface,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      keepPrimary: true,
      keepSecondary: true,
      keepTertiary: true,
    ),
    tones: FlexSchemeVariant.ultraContrast
        .tones(Brightness.light)
        .monochromeSurfaces()
        .onMainsUseBW()
        .onSurfacesUseBW(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    swapLegacyOnMaterial3: true,
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.blackWhite,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 2.0,
    darkIsTrueBlack: true,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      segmentedButtonSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 43,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      fabSchemeColor: SchemeColor.tertiary,
      popupMenuRadius: 6.0,
      popupMenuElevation: 4.0,
      alignedDropdown: true,
      dialogElevation: 3.0,
      dialogRadius: 20.0,
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomSheetRadius: 20.0,
      bottomSheetElevation: 2.0,
      bottomSheetModalElevation: 3.0,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surfaceContainer,
      menuRadius: 6.0,
      menuElevation: 4.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      searchBarElevation: 3.0,
      searchViewElevation: 3.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.surface,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarBackgroundSchemeColor: SchemeColor.surface,
      navigationBarElevation: 1.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.surface,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
    ),
    tones: FlexSchemeVariant.ultraContrast
        .tones(Brightness.dark)
        .monochromeSurfaces(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    swapLegacyOnMaterial3: true,
  );
}
