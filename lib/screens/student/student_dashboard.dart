import 'dart:developer';

import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/screens/director/classes/director_class_subjects.dart';
import 'package:evidyalaya/screens/director/director_chat.dart';
import 'package:evidyalaya/screens/student/director_class_subjects.dart';
import 'package:evidyalaya/screens/teacher/teacher_classes.dart';
import 'package:evidyalaya/screens/teacher/teacher_students.dart';
import 'package:evidyalaya/screens/teacher/teacher_subject.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:evidyalaya/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDashBoard extends StatelessWidget {
  const StudentDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: [
        DashBoardTiles(
            imagePath: 'images/clipboard.png',
            title: 'Subjects',
            onPress: () {
              log(blocProvider.userModel!.currentClass.toString());
              changeScreen(
                  context,
                  StudentClassSubjects(
                    classId: blocProvider.userModel!.currentClass,
                  ));
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
