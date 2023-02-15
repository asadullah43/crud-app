import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/res/components/round_button.dart';
import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:crud_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/constant.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final addController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        centerTitle: true,
        backgroundColor: Constant.kAppbarClr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: addController,
            maxLines: 4,
            decoration: const InputDecoration(
                hintText: 'What is in your mind', border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 30,
          ),
          RoundButton(
              title: 'Add',
              onPress: () {
                Navigator.pushNamed(context, RoutesName.dataScreen);
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                  'title': addController.text.toString(),
                  'id': id,
                }).then((value) {
                  setState(() {
                    loading = false;
                    Navigator.pushNamed(context, RoutesName.dataScreen);
                  });
                  Utils().showSuccessToast('data added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                    Navigator.pushNamed(context, RoutesName.dataScreen);
                  });
                  Utils().flushBarErrorMessage(error.toString(), context);
                });
              }),
        ]),
      ),
    );
  }
}
