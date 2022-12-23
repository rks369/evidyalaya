import 'package:evidyalaya/widgets/loading.dart';
import 'package:flutter/material.dart';

showProgressDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Loading();
      });
}