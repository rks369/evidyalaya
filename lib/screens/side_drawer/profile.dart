import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/bloc/connection_cubit.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/screens/auth/change_password.dart';
import 'package:evidyalaya/screens/auth/forgot_password.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:evidyalaya/widgets/error.dart';
import 'package:evidyalaya/widgets/loading.dart';
import 'package:evidyalaya/widgets/no_internet.dart';
import 'package:evidyalaya/widgets/simple_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = BlocProvider.of<AuthCubit>(context).userModel!;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          SizedBox(
            width: 56,
          ),
        ],
      ),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Account Settings",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(userModel.profilePicture),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SimpleTile(
                    title: userModel.name,
                    ontap: () {},
                    firsticon: const Icon(
                      Icons.verified,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  SimpleTile(
                    title: userModel.userName,
                    ontap: () {},
                    firsticon: const Icon(
                      Icons.person,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  SimpleTile(
                    title: userModel.phone,
                    ontap: () {},
                    firsticon: const Icon(
                      Icons.phone,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  SimpleTile(
                    title: userModel.email,
                    ontap: () {},
                    firsticon: const Icon(
                      Icons.email,
                    ),
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  SimpleTile(
                      title: "Change Passsword",
                      lasticon: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      ontap: () {
                        changeScreen(context, ChangePassword());
                      },
                      firsticon: const Icon(
                        Icons.published_with_changes,
                      )),
                  SimpleTile(
                    title: "Logout",
                    lasticon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    ontap: () {},
                    firsticon: const Icon(
                      Icons.power_settings_new,
                    ),
                  )
                ],
              ),
            );
        }
      }),
    );
  }
}
