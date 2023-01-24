import 'package:evidyalaya/models/class_model.dart';
import 'package:evidyalaya/models/subject_model.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/utils/constant.dart';
import 'package:mysql1/mysql1.dart';

class TeaherMySQLHelper {
  static Future<List<ClassModel>> getClassList(
      String domainName, int teacherId) {
    List<ClassModel> teacherList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query(
          'SELECT * FROM `class_list` where `class_teacher_id`= ?',
          [teacherId]).then((result) {
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
      String domainName, int teaherId) {
    List<SubjectModel> teacherList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query(
          'SELECT * FROM `subject_list` WHERE `subject_teacher_id` = ?',
          [teaherId]).then((result) {
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

  static Future<List<UserModel>> getStudentList(
      String domainName, int teacherId) {
    List<UserModel> studentList = [];
    return MySqlConnection.connect(getConnctionSettings(domainName))
        .then((conn) {
      return conn.query(
          'SELECT * FROM users,class_list WHERE users.current_class = class_list.class_id AND class_list.class_teacher_id = ?',
          [teacherId]).then((result) {
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
}
