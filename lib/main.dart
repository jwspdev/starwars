import 'package:flutter/material.dart';
import 'package:star_wars_app/src/config/routes.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';

void main() {
  initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
