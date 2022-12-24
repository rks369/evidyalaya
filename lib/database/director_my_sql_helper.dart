import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/utils/constant.dart';
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
}
