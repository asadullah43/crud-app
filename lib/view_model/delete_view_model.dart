import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class DeleteViewModel {
  Future<void> delete(BuildContext context, String id) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(id);
    await ref.delete().then((value) {
      Utils().showSuccessToast('Post deleted');
    }).onError((error, stackTrace) {
      Utils().flushBarErrorMessage(error.toString(), context);
    });
    Navigator.pushNamed(context, RoutesName.dataScreen);
  }
}
