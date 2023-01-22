import 'package:evidyalaya/screens/director/classes/director_add_class.dart';
import 'package:evidyalaya/services/change_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, const DirectorAddClass());
        },
        child: const Icon(Icons.add),
      ),
      body: const Text('Classes'),
    );
  }
}
