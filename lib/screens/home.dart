import 'package:evidyalaya/screens/director/director_dashboard.dart';
import 'package:evidyalaya/widgets/slide_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> dashBoardList = [const DirectorDashBoard()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Vidyalaya'),
      ),
      drawer: const SideDrawer(),
      body: dashBoardList[0],
    );
  }
}
