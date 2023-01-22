import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:evidyalaya/bloc/auth_cubit.dart';
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

  static Future<void> createClass(
      BuildContext context, String className, UserModel tecaher) {
    final bloacProvider = BlocProvider.of<AuthCubit>(context);

    return MySqlConnection.connect(
            getConnctionSettings(bloacProvider.domainName))
        .then((conn) {
      return conn.query(
          'INSERT INTO `class_list` (`class_id`, `class_name`, `class_teaher_id`) VALUES (NULL, ?, ?);',
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
