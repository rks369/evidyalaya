import 'package:evidyalaya/database/my_sql_helper.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { init, loading, loggedIn, loggedOut, error }

class AuthCubit extends Cubit<AuthState> {
  UserModel? userModel;
  late String domainName;
  late int userId;
  AuthCubit() : super(AuthState.loading) {
    authCheck();
    emit(AuthState.loading);
  }
  void authCheck() async {
    SharedPreferences.getInstance().then((sharedPreferences) async {
      if (sharedPreferences.getBool('loggedIn') ?? false) {
        domainName = sharedPreferences.getString('domainName') ?? "";
        userId = sharedPreferences.getInt('id') ?? -1;

        if (domainName.isEmpty) {
          emit(AuthState.loggedOut);
        } else {
          await MySQLHelper.getUser(userId, domainName).then((value) {
            if (value != null) {
              emit(AuthState.loggedIn);
              userModel = value;
            } else {
              emit(AuthState.loggedOut);
            }
          });
        }
      } else {
        emit(AuthState.loggedOut);
      }
    });
  }

  void login(UserModel userModel, String domain) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', true);
      sharedPreferences.setInt('id', userModel.id);
      sharedPreferences.setString('domainName', domain);

      this.userModel = userModel;
      userId = userModel.id;
      domainName = domain;
      emit(AuthState.loggedIn);
      return;
    });
  }

  void logout() async {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setBool('loggedIn', false);
      sharedPreferences.setInt('id', -1);
      sharedPreferences.setString('domainName', "");

      emit(AuthState.loggedOut);
      return;
    });
  }
}
