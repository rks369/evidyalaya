import 'package:flutter/material.dart';

class DirectorChat extends StatelessWidget {
  const DirectorChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Chat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: const Text('Chat'),
    );
  }
}
