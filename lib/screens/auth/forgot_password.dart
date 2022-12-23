import 'package:evidyalaya/screens/auth/login.dart';
import 'package:evidyalaya/screens/home.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    const Icon(
                      Icons.school_rounded,
                      size: 75,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'E-Vidyalaya ',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Reset Password',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'to Change Your Password',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter The User ID ...',
                        labelText: 'User ID',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeScreen(context, const Login());
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      onPressed: () =>
                          {changeScreenReplacement(context, const Home())},
                      child: const Text(
                        'Reset',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
