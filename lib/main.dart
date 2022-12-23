import 'package:evidyalaya/bloc/connection_cubit.dart';
import 'package:evidyalaya/screens/auth/login.dart';
import 'package:evidyalaya/widgets/error.dart';
import 'package:evidyalaya/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => ConnectionCubit())],
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
            appBar: AppBar(
              title: const Text('E-Vidyalaya'),
            ),
            body: BlocBuilder<ConnectionCubit, ConnectionStates>(
                builder: (context, state) {
              switch (state) {
                case ConnectionStates.checking:
                  return const Loading();
                case ConnectionStates.notConnected:
                  return Container();

                case ConnectionStates.error:
                  return const ErrorScreen();

                case ConnectionStates.connected:
                  return const Login();
              }
            }),
          ),
        ));
  }
}
