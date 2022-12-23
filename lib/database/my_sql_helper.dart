import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/utils/constant.dart';
import 'package:evidyalaya/utils/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';

class MySQLHelper {
  static Future<bool> domianExists(BuildContext context, String domainName) {
    return MySqlConnection.connect(eVidalayaDBsettings).then((conn) {
      return conn.query('SELECT * FROM `institute` WHERE `domain` = ?',
          [domainName]).then((result) {
        if (result.isEmpty) {
          conn.close();
          return false;
        } else {
          conn.close();
          return true;
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, 'Soe=mething Went Wrong !$error');
        conn.close();
        return false;
      });
    }).onError((error, stackTrace) {
      showErrorMessage(context, 'Soe=mething Went Wrong !$error');
      return false;
    });
  }

  static Future<UserModel?> login(BuildContext context, String username,
      String password, String domianName) async {
    return await MySqlConnection.connect(getConnctionSettings(domianName))
        .then((conn) async {
      return await conn
          .query('SELECT * FROM `users` WHERE `username` =?', [username]).then(
              (value) {
        if (value.isEmpty) {
          showErrorMessage(context, 'No user Exists');
          return null;
        } else {
          final hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
          final passwordDigest =
              hmacSha256.convert(utf8.encode(password)).toString();
          if (value.first['username'] != username) {
            showErrorMessage(context, 'No user Exists');
            return null;
          } else if (value.first['password'] != passwordDigest) {
            showErrorMessage(context, 'Wrong Password');
            return null;
          } else {
            showSuccessMessage(context, 'Login SucessFully');

            return UserModel(
                id: value.first['id'],
                name: value.first['name'],
                email: value.first['email'],
                phone: value.first['phone'],
                userName: value.first['username'],
                designation: value.first['designation']);
          }
        }
      }).onError((error, stackTrace) {
        showErrorMessage(context, error.toString());
        return null;
      });
    });
  }
}
