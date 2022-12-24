import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/utils/constant.dart';
import 'package:evidyalaya/utils/custom_snack_bar.dart';
import 'package:flutter/material.dart';
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
          ..recipients.add('rkstuvwxyz@gmail.com')
          ..subject = 'Director Login Credentials'
          ..text =
              'Welcome To E-Vidyalaya.\nDirector Login Credentials. \n\n\nUser Id  : $userName  \nPassword : $password';

        await send(message, smtpServer).whenComplete(() {
          showSuccessMessage(context, 'Institute Added Sucessfully');
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
