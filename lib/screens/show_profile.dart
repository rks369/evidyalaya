import 'package:evidyalaya/bloc/connection_cubit.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/widgets/error.dart';
import 'package:evidyalaya/widgets/loading.dart';
import 'package:evidyalaya/widgets/no_internet.dart';
import 'package:evidyalaya/widgets/simple_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowProfile extends StatelessWidget {
  final UserModel userModel;
  const ShowProfile({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    lasticon: const Visibility(
                      visible: false,
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                  SimpleTile(
                    title: userModel.userName,
                    ontap: () {},
                    firsticon: const Icon(
                      Icons.person,
                    ),
                    lasticon: const Visibility(
                      visible: false,
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                  SimpleTile(
                    title: userModel.phone,
                    ontap: () async {
                      await launchUrl(
                        Uri(
                          scheme: 'tel',
                          path: userModel.phone,
                        ),
                      );
                    },
                    firsticon: const Icon(
                      Icons.phone,
                    ),
                    lasticon: const Visibility(
                      visible: false,
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                  SimpleTile(
                    title: userModel.email,
                    ontap: () async {
                      await launchUrl(
                        Uri(
                          scheme: 'mailto',
                          path: userModel.email,
                        ),
                      );
                    },
                    firsticon: const Icon(
                      Icons.email,
                    ),
                    lasticon: const Visibility(
                      visible: false,
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
