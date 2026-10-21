import 'package:flutter/material.dart';
import 'screens/main_shell.dart';

void main() => runApp(const SaveFoodApp());

class SaveFoodApp extends StatelessWidget {
  const SaveFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save Food',
      debugShowCheckedModeBanner: false,
      // Material Design 3 dengan color scheme dari satu warna seed
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
      ),
      home: const MainShell(),
    );
  }
}
