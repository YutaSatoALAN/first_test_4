import 'package:first_test_4/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final mailController = TextEditingController();
  final pwController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
          backgroundColor: Colors.teal,
        ),
        body: Consumer<SignUpModel>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'アドレスを入力'),
                  controller: mailController,
                  onChanged: (text) {
                    model.mail = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'パスワードを入力'),
                  obscureText: true,
                  controller: pwController,
                  onChanged: (text) {
                    model.pw = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'ユーザー名を入力'),
                  controller: usernameController,
                  onChanged: (text) {
                    model.username = text;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  child: Text(
                    '新規登録',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await model.signUp();
                      await _showDialog(context, model.message);
                      if (model.message == '登録完了しました') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ),
                            (_) => false);
                      }
                    } catch (e) {
                      _showDialog(context, e.toString());
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Future _showDialog(BuildContext context, String title) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
