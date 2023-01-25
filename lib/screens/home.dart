import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/screens/director/director_dashboard.dart';
import 'package:evidyalaya/screens/student/student_dashboard.dart';
import 'package:evidyalaya/screens/teacher/teacher_dashboard.dart';
import 'package:evidyalaya/widgets/slide_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> dashBoardList = [
      const DirectorDashBoard(),
      const TeacherDashBoard(),
      const StudentDashBoard()
    ];

    getDashBoard() {
      final blocProvider = BlocProvider.of<AuthCubit>(context);
      if (blocProvider.userModel!.designation == 'Director') {
        return dashBoardList[0];
      }
      if (blocProvider.userModel!.designation == 'Teacher') {
        return dashBoardList[1];
      }
      if (blocProvider.userModel!.designation == 'Student') {
        return dashBoardList[2];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Vidyalaya'),
      ),
      drawer: const SideDrawer(),
      body: getDashBoard(),
    );
  }
}
