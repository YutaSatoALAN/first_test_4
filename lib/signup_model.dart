import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String pw = '';
  String username = '';
  String message = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp() async {
    await Firebase.initializeApp();
    if (this.mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (this.pw.isEmpty) {
      throw ('パスワードを入力してください');
    }
    if (this.username.isEmpty) {
      throw ('ユーザー名を入力してください');
    }

    try {
      print('createの前');
      await this._auth.createUserWithEmailAndPassword(
            email: this.mail,
            password: this.pw,
          );
      print('Setの前');
      await FirebaseFirestore.instance.collection('users').doc(this.mail).set(
        {
          'email': this.mail,
          'username': this.username,
          'createdAt': Timestamp.now(),
        },
      );
      print('message格納の前');
      this.message = '登録完了しました';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        this.message = 'パスワードが虚弱です';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        this.message = 'すでに登録されたアドレスです';
      }
    } catch (e) {
      print(e);
      this.message = '不明なエラー';
    }
  }
}
