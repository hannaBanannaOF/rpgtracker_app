import 'package:flutter/material.dart';
import 'package:rpgtracker_app/extensions/string.dart';

class Toast {
  Toast._();

  static void showDeleteSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('notifications:delete.success'.translate(context)),
      ),
    );
  }

  static void showDeleteError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('notifications:delete.error'.translate(context)),
      ),
    );
  }
}
