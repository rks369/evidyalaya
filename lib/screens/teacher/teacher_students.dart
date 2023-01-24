import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/database/director_my_sql_helper.dart';
import 'package:evidyalaya/database/teacher_my_sql_helper.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/screens/director/student/director_add_student.dart';
import 'package:evidyalaya/screens/show_profile.dart';
import 'package:evidyalaya/screens/teacher/teacher_add_student.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:evidyalaya/widgets/error.dart';
import 'package:evidyalaya/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherStudents extends StatelessWidget {
  const TeacherStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Students',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, const TeacherAddStudent());
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: TeaherMySQLHelper.getStudentList(
              blocProvider.domainName, blocProvider.userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const ErrorScreen();
            if (!snapshot.hasData) {
              return const Loading();
            } else {
              List<UserModel> list = snapshot.data!;

              if (list.isEmpty) {
                return Center(
                  child: Text(
                    'No Student Exists !!!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        changeScreen(
                            context, ShowProfile(userModel: list[index]));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(list[index].profilePicture),
                          ),
                          title: Text(list[index].name),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
