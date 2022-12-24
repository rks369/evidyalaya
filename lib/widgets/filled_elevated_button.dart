import 'package:flutter/material.dart';

class FilledElevatedButton extends StatelessWidget {
  const FilledElevatedButton({Key? key, required this.onPress})
      : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: onPress,
        child: const Text('Add'));
  }
}