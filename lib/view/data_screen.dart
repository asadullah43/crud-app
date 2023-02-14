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

  final editControler = TextEditingController();

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
          const SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.pushNamed(context, RoutesName.addData);
        }),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: ((BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  const Text('Some erorr');
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final title =
                              snapshot.data!.docs[index]['title'].toString();

                          return ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle:
                                Text(snapshot.data!.docs[index].id.toString()),
                            trailing: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMyDialog(
                                            title,
                                            snapshot.data!.docs[index].id
                                                .toString());
                                      },
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                    )),
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        ref
                                            .doc(snapshot.data!.docs[index].id
                                                .toString())
                                            .delete();
                                      },
                                      leading: const Icon(Icons.delete_outline),
                                      title: const Text('Delete'),
                                    ))
                              ],
                            ),
                          );
                        }));
              })),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editControler.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              controller: editControler,
              decoration: const InputDecoration(hintText: 'edit here'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    final ref =
                        FirebaseFirestore.instance.collection('users').doc(id);
                    await ref.update({
                      'title': editControler.text,
                    }).then((value) {
                      Utils().flushBarErrorMessage('Post update', context);
                      Navigator.pushNamed(context, RoutesName.dataScreen);
                    }).onError((error, stackTrace) {
                      Utils().flushBarErrorMessage(error.toString(), context);
                    });
                  },
                  child: const Text('Update'))
            ],
          );
        });
  }
}
