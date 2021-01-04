import 'package:firebase_core/firebase_core.dart';
import 'package:first_test_4/signin_page.dart';
import 'package:first_test_4/signup_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firstTest3',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('評価アプリ Test3'),
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
        child: Container(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      child: RaisedButton(
                        child: Text(
                          'ログイン',
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
                              builder: (context) => SingInPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: RaisedButton(
                        child: Text(
                          '新規登録',
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
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 15.0,
                right: 15.0,
                child: Text(
                  'presented by YS from ALAN',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Positioned(
                top: 15.0,
                right: 15.0,
                child: Image.asset(
                  'images/logo.png',
                  scale: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
