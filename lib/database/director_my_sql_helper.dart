import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/models/class_model.dart';
import 'package:evidyalaya/models/subject_model.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/utils/constant.dart';
import 'package:evidyalaya/utils/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mailer/mailer.dart';
import 'package:mysql1/mysql1.dart';

class DirectorMySQLHelper {
  static Future<List<UserModel>> getStudentList(String domainName) {
    List<UserModel> studentList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query('SELECT * FROM `users` WHERE `designation` = ?',
          ['Student']).then((result) {
        for (var row in result) {
          studentList.add(UserModel(
              id: row['id'],
              name: row['name'],
              email: row['email'],
              phone: row['phone'],
              userName: row['username'],
              designation: row['designation'],
              profilePicture: row['profile_picture']));
        }
        return studentList;
      }).onError((error, stackTrace) {
        return studentList;
      });
    }).onError((error, stackTrace) {
      return studentList;
    });
  }

  static Future<List<UserModel>> getTeachersList(String domainName) {
    List<UserModel> teacherList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query('SELECT * FROM `users` WHERE `designation` = ?',
          ['Teacher']).then((result) {
        for (var row in result) {
          teacherList.add(UserModel(
              id: row['id'],
              name: row['name'],
              email: row['email'],
              phone: row['phone'],
              userName: row['username'],
              designation: row['designation'],
              profilePicture: row['profile_picture']));
        }
        return teacherList;
      }).onError((error, stackTrace) {
        return teacherList;
      });
    }).onError((error, stackTrace) {
      return teacherList;
    });
  }

  static Future<List<ClassModel>> getClassList(String domainName) {
    List<ClassModel> teacherList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query('SELECT * FROM `class_list`').then((result) {
        for (var row in result) {
          teacherList.add(ClassModel(
              id: row['class_id'],
              name: row['class_name'],
              teacherId: row['class_teacher_id']));
        }
        return teacherList;
      }).onError((error, stackTrace) {
        return teacherList;
      });
    }).onError((error, stackTrace) {
      return teacherList;
    });
  }

  static Future<List<SubjectModel>> getSubjectList(
      String domainName, int classId) {
    List<SubjectModel> teacherList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query('SELECT * FROM `subject_list`  WHERE `class_id` = ?',
          [classId]).then((result) {
        for (var row in result) {
          teacherList.add(SubjectModel(
              id: row['subject_id'],
              classId: row['class_id'],
              name: row['subject_name'],
              teacherId: row['subject_teacher_id']));
        }
        return teacherList;
      }).onError((error, stackTrace) {
        return teacherList;
      });
    }).onError((error, stackTrace) {
      return teacherList;
    });
  }

  static Future<void> createClass(
      BuildContext context, String className, UserModel tecaher) {
    final bloacProvider = BlocProvider.of<AuthCubit>(context);

    return MySqlConnection.connect(
            getConnctionSettings(bloacProvider.domainName))
        .then((conn) {
      return conn.query(
          'INSERT INTO `class_list` (`class_id`, `class_name`, `class_teacher_id`) VALUES (NULL, ?, ?);',
          [className, tecaher.id]).then((value) async {
        conn.close();
        final message = Message()
          ..from = senderAdress
          ..recipients.add(tecaher.email)
          ..subject = 'You Are Now Class In-charger Of $className'
          ..text =
              'Welcome To E-Vidyalaya.\nYou Are Now Class In-charger Of $className';

        await send(message, smtpServer).whenComplete(() {
          showSuccessMessage(context, 'Class Created Sucessfully');
          Navigator.pop(context);
          Navigator.pop(context);
        });
        return;
      }).onError((error, stackTrace) {
        conn.close();

        showErrorMessage(context, 'Something went wrong $error');
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, 'Something went wrong $error');
    });
  }

  static Future<void> addSubject(BuildContext context, int classId,
      String subjectName, UserModel tecaher) {
    final bloacProvider = BlocProvider.of<AuthCubit>(context);

    return MySqlConnection.connect(
            getConnctionSettings(bloacProvider.domainName))
        .then((conn) {
      return conn.query(
          'INSERT INTO `subject_list` (`subject_id`, `subject_name`, `class_id`, `subject_teacher_id`) VALUES (NULL, ?, ?, ?);',
          [subjectName, classId, tecaher.id]).then((value) async {
        conn.close();
        final message = Message()
          ..from = senderAdress
          ..recipients.add(tecaher.email)
          ..subject = 'You Are Now Subject Teacher Of $subjectName'
          ..text =
              'Welcome To E-Vidyalaya.\nYou Are Now Subject Teacher Of $subjectName';

        await send(message, smtpServer).whenComplete(() {
          showSuccessMessage(context, 'Class Created Sucessfully');
          Navigator.pop(context);
          Navigator.pop(context);
        });
        return;
      }).onError((error, stackTrace) {
        conn.close();

        showErrorMessage(context, 'Something went wrong $error');
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, 'Something went wrong $error');
    });
  }

  static Future<void> addteacher(
      BuildContext context, UserModel userModel, String domain) {
    String password = 'teacher@123';
    String userName = userModel.userName;
    final hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
    final passwordDigest = hmacSha256.convert(utf8.encode(password)).toString();
    return MySqlConnection.connect(getConnctionSettings(domain)).then((conn) {
      return conn.query(
          'INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `username`,`designation`,`profile_picture`) VALUES (NULL,?,?, ?, ?, ?,?,?);',
          [
            userModel.name,
            userModel.email,
            userModel.phone,
            passwordDigest,
            userModel.userName,
            userModel.designation,
            userModel.profilePicture
          ]).then((value) async {
        conn.close();
        final message = Message()
          ..from = senderAdress
          ..recipients.add(userModel.email)
          ..subject = 'Teacher Login Credentials'
          ..text =
              'Welcome To E-Vidyalaya.\nTeacher Login Credentials. \n\n\nUser Id  : $userName  \nPassword : $password';

        await send(message, smtpServer).whenComplete(() {
          showSuccessMessage(context, 'Teacher Added Sucessfully');
          Navigator.pop(context);
          Navigator.pop(context);
        });
        return;
      }).onError((error, stackTrace) {
        conn.close();

        showErrorMessage(context, 'Something went wrong $error');
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, 'Something went wrong $error');
    });
  }

  static Future<void> addStudent(
      BuildContext context, UserModel userModel, String domain) {
    String password = 'student@123';
    String userName = userModel.userName;
    final hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
    final passwordDigest = hmacSha256.convert(utf8.encode(password)).toString();
    return MySqlConnection.connect(getConnctionSettings(domain)).then((conn) {
      return conn.query(
          'INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `username`,`designation`,`profile_picture`) VALUES (NULL,?,?, ?, ?, ?,?,?);',
          [
            userModel.name,
            userModel.email,
            userModel.phone,
            passwordDigest,
            userModel.userName,
            userModel.designation,
            userModel.profilePicture
          ]).then((value) async {
        conn.close();
        final message = Message()
          ..from = senderAdress
          ..recipients.add(userModel.email)
          ..subject = 'Student Login Credentials'
          ..text =
              'Welcome To E-Vidyalaya.\nStudent Login Credentials. \n\n\nUser Id  : $userName  \nPassword : $password';

        await send(message, smtpServer).whenComplete(() {
          showSuccessMessage(context, 'Student Added Sucessfully');
          Navigator.pop(context);
          Navigator.pop(context);
        });
        return;
      }).onError((error, stackTrace) {
        conn.close();

        showErrorMessage(context, 'Something went wrong $error');
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, 'Something went wrong $error');
    });
  }
}
