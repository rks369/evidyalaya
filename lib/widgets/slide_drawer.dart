import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/screens/auth/login.dart';
import 'package:evidyalaya/screens/side_drawer/about_us.dart';
import 'package:evidyalaya/screens/side_drawer/contact_us.dart';
import 'package:evidyalaya/screens/side_drawer/privacy_policy.dart';
import 'package:evidyalaya/screens/side_drawer/profile.dart';
import 'package:evidyalaya/screens/side_drawer/terms_condition.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    final UserModel userModel = blocProvider.userModel!;

    return SafeArea(
      child: Drawer(
        child: Column(children: [
          const SizedBox(
            height: 20.0,
          ),
          CircleAvatar(
            radius: 75.0,
            backgroundImage: NetworkImage(userModel.profilePicture),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            userModel.name,
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            userModel.designation,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            userModel.phone,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            userModel.email,
          ),
          const SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Profile'),
            onTap: () {
              changeScreen(context, const UserProfile());
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              changeScreen(context, const AboutUs());
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact Us'),
            onTap: () {
              changeScreen(context, const ContactUs());
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy Policy'),
            onTap: () {
              changeScreen(context, const PrivacyPloicy());
            },
          ),
          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text('Terms & Conditions'),
            onTap: () {
              changeScreen(context, const TermsAndCondtions());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              blocProvider.logout();
              changeScreenReplacement(context, Login());
            },
          ),
        ]),
      ),
    );
  }
}
