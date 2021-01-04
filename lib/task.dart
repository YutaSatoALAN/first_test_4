import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  String taskName;
  String taskID;

  Task(DocumentSnapshot doc){
    this.taskName = doc.data()['taskName'];
    this.taskID = doc.data()['taskID'];
  }
}