import 'package:first_test_4/main_page.dart';
import 'package:first_test_4/signin_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingInPage extends StatefulWidget {
  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  final mailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
          backgroundColor: Colors.teal,
        ),
        body: Consumer<SignInModel>(builder: (context, model, child) {
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
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  child: Text(
                    'ログイン',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await model.signIn();
                      await _showDialog(context, model.message);
                      if (model.message == 'ログイン完了') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(model.email),
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
