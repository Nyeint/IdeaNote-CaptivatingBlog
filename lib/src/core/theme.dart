import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'color_resources.dart';

ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.amber,
  primary: ColorResources.primary,
  secondary: ColorResources.secondary,
  background: ColorResources.background,
  fontFamily: 'K2D',
  textTheme: const TextTheme(),
  useMaterial3: true
);

ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.amber,
    primary: ColorResources.primary,
    secondary: ColorResources.secondary,
    fontFamily: 'K2D',
    useMaterial3: true
);