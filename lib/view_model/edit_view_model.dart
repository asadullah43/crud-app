import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class EditViewModel {
  Future<void> edit(BuildContext context, String title, String id) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(id);
    try {
      await ref.update({
        'title': title,
      });
      Navigator.pushNamed(context, RoutesName.dataScreen);
      Utils().showSuccessToast('Post Update');
    } catch (error) {
      Utils().flushBarErrorMessage(error.toString(), context);
    }
  }
}
