import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';

class AppTheme {
  AppTheme._();
  static final appTheme = ThemeData(
    colorSchemeSeed: CommonColors.colorPrimary,
    useMaterial3: true,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black),
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: CommonColors.colorPrimaryLight,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
          }
          return const TextStyle(
            color: Colors.grey,
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: CommonColors.colorPrimary,
            );
          }
          return const IconThemeData(
            color: Colors.grey,
          );
        },
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      surfaceTintColor: Colors.white,
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Set global corner radius
      ),
    ),
  );
}