import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  String mail = '';
  String pw = '';
  String message = 'Error';
  String email = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください');
    }
    if (pw.isEmpty) {
      throw ('パスワードを入力してください');
    }
    try {
      UserCredential userCredential =
          await this._auth.signInWithEmailAndPassword(
                email: mail,
                password: pw,
              );
      this.email = userCredential.user.email;
      message = 'ログイン完了';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      message = 'メールアドレスもしくはパスワードが間違っています';
    }
    ChangeNotifier();
  }
}
