import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class EditViewModel {
  Future<void> edit(BuildContext context, String title, String id) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(id);
    await ref.update({
      'title': title,
    }).then((value) {
      Utils().showSuccessToast('Post Update');
    }).onError((error, stackTrace) {
      Utils().flushBarErrorMessage(error.toString(), context);
    });
    Navigator.pushNamed(context, RoutesName.dataScreen);
  }
}
