import 'package:evidyalaya/utils/constant.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Vidyalaya'),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(children: [
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 75.0,
              backgroundImage: Image.network(dummyUserProfileLink).image,
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              'Ritesh',
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Text(
              'Student',
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Text(
              '+91 87087272170',
            ),
            const SizedBox(
              height: 20.0,
            ),
            const ListTile(
              leading: Icon(Icons.people),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(Icons.security),
              title: Text('Privacy Policy'),
            ),
            const ListTile(
              leading: Icon(Icons.policy),
              title: Text('Terms & Conditions'),
            ),
            const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ]),
        ),
      ),
      body: const Text('Home'),
    );
  }
}
