import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/database/director_my_sql_helper.dart';
import 'package:evidyalaya/models/class_model.dart';
import 'package:evidyalaya/models/user_model.dart';
import 'package:evidyalaya/screens/auth/login.dart';
import 'package:evidyalaya/services/email_validator.dart';
import 'package:evidyalaya/services/show_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectorAddStudentToClass extends StatefulWidget {
  final int currentClass;
  const DirectorAddStudentToClass({super.key, required this.currentClass});

  @override
  State<DirectorAddStudentToClass> createState() =>
      _DirectorAddStudentToClass();
}

class _DirectorAddStudentToClass extends State<DirectorAddStudentToClass> {
  List<ClassModel> classList = [];
  @override
  void initState() {
    getClassList();
    super.initState();
  }

  getClassList() async {
    final blocProvider = BlocProvider.of<AuthCubit>(context);

    DirectorMySQLHelper.getClassList(
      blocProvider.domainName,
    ).then((value) {
      classList = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final String domain = BlocProvider.of<AuthCubit>(context).domainName;

    final TextEditingController name = TextEditingController();
    final TextEditingController roll = TextEditingController();

    final TextEditingController email = TextEditingController();
    final TextEditingController mobile = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  const Icon(
                    Icons.school_rounded,
                    size: 75,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'E-Vidyalaya ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Add Student',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Enter Details to Add Student',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (value.length < 3) {
                        return 'Name Should be of 3 Character';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: roll,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Roll Number';
                      } else if (value.length < 3) {
                        return 'Roll Number Should be of 3 Character';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Roll Number',
                      hintText: 'Enter RollNumber',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter A Email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please Enter A Valid Email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                      hintText: 'Enter E-mail',
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: mobile,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Mobile Number';
                      } else if (value.length != 10) {
                        return 'Mobile Number Should be of 10 digits';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile',
                      hintText: 'Enter Mobile Number',
                      prefixIcon: Icon(Icons.smartphone),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledElevatedButoon(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        showProgressDialog(context);
                        UserModel userModel = UserModel(
                            id: 0,
                            name: name.text,
                            email: email.text,
                            phone: mobile.text,
                            // ignore: prefer_interpolation_to_compose_strings
                            userName: name.text.split(' ')[0] +
                                roll.text +
                                '@' +
                                domain +
                                '.evidyalaya.in',
                            designation: 'Student',
                            profilePicture: 'profilePicture');

                        DirectorMySQLHelper.addStudent(
                                context, userModel, domain, widget.currentClass)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Text('Add Student'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
