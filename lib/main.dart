import 'package:flutter/material.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/home_page.dart';

void main() {
  initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
