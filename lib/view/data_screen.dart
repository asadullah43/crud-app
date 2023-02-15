import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
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
        centerTitle: true,
        title: const Text('Post screen firestore'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addData);
        },
        child: const Icon(Icons.add),
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
                            onPressed: () {
                              showEditDialog(title,
                                  snapshot.data!.docs[index].id.toString());
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(
                                  snapshot.data!.docs[index].id.toString());
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

  Future<void> showEditDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Update'),
              content: TextField(
                controller: editController,
                decoration: const InputDecoration(hintText: 'Edit here'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                    onPressed: () async {
                      final ref = FirebaseFirestore.instance
                          .collection('users')
                          .doc(id);
                      await ref.update({
                        'title': editController.text,
                      }).then((value) {
                        Utils().showSuccessToast('Post Update');
                      }).onError((error, stackTrace) {
                        Utils().flushBarErrorMessage(error.toString(), context);
                      });
                      Navigator.pushNamed(context, RoutesName.dataScreen);
                    },
                    child: const Text('Update')),
              ]);
        });
  }

  Future<void> showDeleteDialog(String id) async {
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final ref =
                    FirebaseFirestore.instance.collection('users').doc(id);
                await ref.delete().then((value) {
                  Utils().showSuccessToast('Post deleted');
                }).onError((error, stackTrace) {
                  Utils().flushBarErrorMessage(error.toString(), context);
                });
                Navigator.pushNamed(context, RoutesName.dataScreen);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
