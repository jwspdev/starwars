import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('home'),
      ),
    );
  }
}
