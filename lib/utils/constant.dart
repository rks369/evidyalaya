import 'dart:convert';

import 'package:mysql1/mysql1.dart';

const String dummyUserProfileLink =
    'https://images.unsplash.com/photo-1566753323558-f4e0952af115?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1021&q=80';

final eVidalayaDBsettings = ConnectionSettings(
    host: '192.168.214.134', port: 3306, user: 'root', db: 'evidalaya');

ConnectionSettings getConnctionSettings(String db) {
  return ConnectionSettings(
      host: '192.168.214.134', port: 3306, user: 'root', db: db);
}

final secretKey = utf8.encode('evidyalaya');