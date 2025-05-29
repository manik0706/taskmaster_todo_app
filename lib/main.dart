import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_demo/bloc/todo_event.dart';
import 'package:new_demo/theme/theme_cubit.dart';
import 'bloc/todo_bloc.dart';
import 'data/todo_repository.dart';
import 'screens/splash_screen.dart'; // Add splash screen import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final todoRepository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodoBloc(todoRepository)..add(LoadTodos()),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'TaskMaster - Todo App',
            theme: themeState.themeData.copyWith(
              // Custom theme enhancements
              appBarTheme: AppBarTheme(
                elevation: 0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeState.currentTheme == AppTheme.light
                      ? Colors.white
                      : Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              cardTheme: CardTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            home: SplashScreen(), // Start with splash screen
            debugShowCheckedModeBanner: false, // Remove debug banner
          );
        },
      ),
    );
  }
}