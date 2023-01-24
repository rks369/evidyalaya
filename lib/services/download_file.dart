import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future openFile(String url, String fileName) async {
  await downlaodFile(url, fileName);
}

downlaodFile(String url, String fileName) async {
  try {
    final appStorage = await getExternalStorageDirectory();

    final id = FlutterDownloader.enqueue(
      url: url,
      savedDir: appStorage!.path,
      fileName: fileName,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification: true,
    );
  } catch (e) {
    return null;
  }
}
