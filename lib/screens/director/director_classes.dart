import 'package:flutter/material.dart';

class DirectorClasses extends StatelessWidget {
  const DirectorClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Classes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: const Text('Classes'),
    );
  }
}
