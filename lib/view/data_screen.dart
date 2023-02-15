import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/res/components/show_dialog.dart';
import 'package:crud_app/utils/routes/routes_name.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/constant.dart';

import '../view_model/signout_view_model.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  final ref = FirebaseFirestore.instance.collection('users');

  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Constant.kAppbarClr,
        centerTitle: true,
        title: const Text('Post Screen'),
        actions: [
          IconButton(
            onPressed: () {
              SignOutViewModel(context).signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          gradient: Constant.kRoundBtnGradient,
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.addData);
          },
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Text('Some error');
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final title =
                        snapshot.data!.docs[index]['title'].toString();

                    return ListTile(
                      title: Text(title),
                      subtitle: Text(snapshot.data!.docs[index].id.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            color: Constant.kBlueColor,
                            onPressed: () {
                              ShowDialog().showEditDialog(
                                  title,
                                  snapshot.data!.docs[index].id.toString(),
                                  'Edit Data ',
                                  'Update',
                                  context);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            color: Constant.kErrorBarIndicatorColor,
                            onPressed: () {
                              ShowDialog().showDeleteDialog(
                                  snapshot.data!.docs[index].id.toString(),
                                  context);
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
