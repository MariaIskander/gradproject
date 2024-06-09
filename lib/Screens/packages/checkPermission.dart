import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> checkPermission(
    Permission permission, BuildContext context) async {
  final Status = await permission.request();
  if (Status == true) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Access Garented')));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Access Denied')));
  }
}
