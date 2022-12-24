import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/bloc/connection_cubit.dart';
import 'package:evidyalaya/firebase_options.dart';
import 'package:evidyalaya/screens/auth/login.dart';
import 'package:evidyalaya/screens/home.dart';
import 'package:evidyalaya/widgets/error.dart';
import 'package:evidyalaya/widgets/loading.dart';
import 'package:evidyalaya/widgets/no_internet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ConnectionCubit()),
          BlocProvider(create: (context) => AuthCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
          ),
          darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
              brightness: Brightness.dark),
          title: 'E-Vidyalaya',
          home: Scaffold(
            body: BlocBuilder<ConnectionCubit, ConnectionStates>(
                builder: (context, state) {
              switch (state) {
                case ConnectionStates.checking:
                  return const Loading();
                case ConnectionStates.notConnected:
                  return const NoInternet();

                case ConnectionStates.error:
                  return const ErrorScreen();

                case ConnectionStates.connected:
                  return BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                    switch (state) {
                      case AuthState.init:
                        return const Scaffold(
                          body: Loading(),
                        );
                      case AuthState.loading:
                        return const Scaffold(
                          body: Loading(),
                        );
                      case AuthState.loggedIn:
                        return const Home();
                      case AuthState.loggedOut:
                        return const Login();
                      case AuthState.error:
                        return const Scaffold(
                          body: ErrorScreen(),
                        );
                    }
                  });
              }
            }),
          ),
        ));
  }
}
