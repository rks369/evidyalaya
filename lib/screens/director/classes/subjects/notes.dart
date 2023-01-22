import 'dart:io';

import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/database/director_my_sql_helper.dart';
import 'package:evidyalaya/models/notes_model.dart';
import 'package:evidyalaya/models/subject_model.dart';
import 'package:evidyalaya/services/change_screen.dart';
import 'package:evidyalaya/utils/constant.dart';
import 'package:evidyalaya/utils/custom_snack_bar.dart';
import 'package:evidyalaya/widgets/error.dart';
import 'package:evidyalaya/widgets/loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Notes extends StatelessWidget {
  final SubjectModel subjectModel;
  const Notes({super.key, required this.subjectModel});

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthCubit>(context);
    uploadFile(File file) {
      showProgressDialog(context);
      FirebaseStorage.instance.ref('notes').putFile(file).then(
        (result) {
          result.ref.getDownloadURL().then((url) {
            DirectorMySQLHelper.addNote(context, subjectModel.id,
                    basename(file.path), extension(file.path), url)
                .whenComplete(() {
              Navigator.pop(context);
            });
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            subjectModel.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          await picker
                              .pickImage(source: ImageSource.camera)
                              .then((xFile) {
                            if (xFile != null) {
                              File file = File(xFile.path);
                              uploadFile(file);
                            } else {
                              showErrorMessage(context, 'No File Selected !!!');
                            }
                          });
                        },
                        child: const Icon(Icons.camera),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['mp4', 'mkv', 'mpg', 'webm'],
                          ).then((result) {
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              uploadFile(file);
                            } else {
                              showErrorMessage(context, 'No File Seleced !!!');
                            }
                          });
                        },
                        child: const Icon(Icons.video_file),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'm4a',
                              'FLAC',
                              'mp3',
                              'mp4',
                              'wav',
                              'wma',
                              'aac'
                            ],
                          ).then((result) {
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              uploadFile(file);
                            } else {
                              showErrorMessage(context, 'No File Seleced !!!');
                            }
                          });
                        },
                        child: const Icon(Icons.audio_file),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc'],
                          ).then((result) {
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              uploadFile(file);
                            } else {
                              showErrorMessage(context, 'No File Seleced !!!');
                            }
                          });
                        },
                        child: const Icon(Icons.document_scanner),
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: DirectorMySQLHelper.getNotesList(
              blocProvider.domainName, subjectModel.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) return const ErrorScreen();
            if (!snapshot.hasData) {
              return const Loading();
            } else {
              List<NotesModel> list = snapshot.data!;

              if (list.isEmpty) {
                return Center(
                  child: Text(
                    'No Notes Exists !!!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                );
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    if (list[index].ext == '.jpg' ||
                        list[index].ext == '.png') {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          list[index].url,
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(extToImage[list[index].ext] ??
                                'images/clipboard.png'),
                          ),
                          Text(list[index].title)
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
