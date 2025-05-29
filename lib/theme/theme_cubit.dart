import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Theme State
enum AppTheme { light, dark }

class ThemeState {
  final ThemeData themeData;
  final AppTheme currentTheme;
  final IconData themeIcon;

  ThemeState({
    required this.themeData,
    required this.currentTheme,
    required this.themeIcon,
  });
}

// Theme Cubit
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
    themeData: ThemeData.light(),
    currentTheme: AppTheme.light,
    themeIcon: Icons.dark_mode,
  ));

  void toggleTheme() {
    if (state.currentTheme == AppTheme.light) {
      emit(ThemeState(
        themeData: ThemeData.dark(),
        currentTheme: AppTheme.dark,
        themeIcon: Icons.light_mode,
      ));
    } else {
      emit(ThemeState(
        themeData: ThemeData.light(),
        currentTheme: AppTheme.light,
        themeIcon: Icons.dark_mode,
      ));
    }
  }

  void setTheme(AppTheme theme) {
    if (theme == AppTheme.dark) {
      emit(ThemeState(
        themeData: ThemeData.dark(),
        currentTheme: AppTheme.dark,
        themeIcon: Icons.light_mode,
      ));
    } else {
      emit(ThemeState(
        themeData: ThemeData.light(),
        currentTheme: AppTheme.light,
        themeIcon: Icons.dark_mode,
      ));
    }
  }
}