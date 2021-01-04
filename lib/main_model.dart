import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String username;
  String email;

  Future getUsername(String email) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    final username = doc.data()['username'];
    this.username = username;
    notifyListeners();
  }
}
