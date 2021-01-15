import 'package:first_test_4/list_page.dart';
import 'package:first_test_4/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class MainPage extends StatefulWidget {
  final String email;

  MainPage(this.email);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    final String email = widget.email;

    return ChangeNotifierProvider(
      create: (_) => MainModel()..getUsername(email),
      child: Consumer<MainModel>(
        builder: (context, model, child) {
          final username = model.username;
          model.email = email;
          return Scaffold(
            appBar: AppBar(
              title: Text('$usernameさんのマイページ'),
              backgroundColor: Colors.teal,
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: RaisedButton(
                        child: Text(
                          '撮影',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        color: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListPage(email),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RaisedButton(
                        child: Text(
                          'データ確認',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        color: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ,
                          //   ),
                          // );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: RaisedButton(
                        child: Text(
                          'ログアウト',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        color: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                              (_) => false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
