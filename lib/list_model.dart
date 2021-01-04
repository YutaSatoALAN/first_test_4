import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_test_4/task.dart';
import 'package:flutter/cupertino.dart';

class ListModel extends ChangeNotifier {
  List<Task> taskList = [];
  String email;

  Future getTaskList() async{
    final snapshot = await FirebaseFirestore.instance.collection('task').get();
    final docs = snapshot.docs;
    final taskList = docs.map((doc) => Task(doc)).toList();
    this.taskList = taskList;
    notifyListeners();
  }

}
