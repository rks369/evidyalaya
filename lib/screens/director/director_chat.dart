import 'package:evidyalaya/screens/director/chat/director_chat_classes.dart';
import 'package:evidyalaya/screens/director/chat/director_chat_students.dart';
import 'package:evidyalaya/screens/director/chat/director_chat_subject.dart';
import 'package:evidyalaya/screens/director/chat/director_chat_teachers.dart';
import 'package:flutter/material.dart';

class DirectorChat extends StatelessWidget {
  const DirectorChat({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Chat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottom: TabBar(indicatorColor: Theme.of(context).primaryColor, tabs: const [
            Tab(
              icon: Icon(Icons.group),
              text: 'Classes',
            ),
            Tab(
              icon: Icon(Icons.class_),
              text: 'Subjects',
            ),
            Tab(
              icon: Icon(Icons.school),
              text: 'Teachers',
            ),
            Tab(
              icon: Icon(Icons.account_box_rounded),
              text: 'Students',
            )
          ]),
        ),
        body: const TabBarView(children: [
          DirectorChatClasses(),
          DirectorChatSubjects(),
          DirectorChatTeachers(),
          DirectorChatStudents()
        ]),
      ),
    );
  }
}
