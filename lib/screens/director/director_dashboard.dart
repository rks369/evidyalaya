import 'package:evidyalaya/screens/director/director_chat.dart';
import 'package:evidyalaya/screens/director/director_classes.dart';
import 'package:evidyalaya/screens/director/director_students.dart';
import 'package:evidyalaya/screens/director/director_teachres.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:evidyalaya/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';

class DirectorDashBoard extends StatelessWidget {
  const DirectorDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: [
        DashBoardTiles(
            imagePath: 'images/class.png',
            title: 'Classes',
            onPress: () {
              changeScreen(context, const DirectorClasses());
            }),
        DashBoardTiles(
            imagePath: 'images/teacher.png',
            title: 'Teachers',
            onPress: () {
              changeScreen(context, const DirectorTeachers());
            }),
        DashBoardTiles(
            imagePath: 'images/student.png',
            title: 'Students',
            onPress: () {
              changeScreen(context, const DirectorStudents());
            }),
        DashBoardTiles(
            imagePath: 'images/chat.png',
            title: 'Chat',
            onPress: () {
              changeScreen(context, const DirectorChat());
            })
      ],
    );
  }
}
