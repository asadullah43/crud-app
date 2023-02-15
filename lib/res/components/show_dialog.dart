import 'package:flutter/material.dart';

import '../../view_model/delete_view_model.dart';
import '../../view_model/edit_view_model.dart';
import '../constant.dart';

class ShowDialog {
  final editController = TextEditingController();
  Future<void> showEditDialog(String title, String id, String dialogTitile,
      String actionBtn, BuildContext context) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(dialogTitile),
              content: TextField(
                controller: editController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Constant.kErrorBarIndicatorColor),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      EditViewModel().edit(context, editController.text, id);
                    },
                    child: Text(actionBtn)),
              ]);
        });
  }

  Future<void> showDeleteDialog(String id, BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to delete this post?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  DeleteViewModel().delete(context, id);
                },
                child: const Text('Delete',
                    style: TextStyle(color: Constant.kErrorBarIndicatorColor)),
              )
            ],
          );
        });
  }
}
