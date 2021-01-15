import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_test_4/check_model.dart';
import 'package:first_test_4/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_compress/flutter_video_compress.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class CheckPage extends StatefulWidget {
  final String taskID;
  final String email;
  final String videoPath;

  CheckPage(this.taskID, this.email, this.videoPath);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool _loading = false;

  @override
  void initState() {
    _controller = VideoPlayerController.file(
      File(widget.videoPath),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    Firebase.initializeApp();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> videoUpload() async {
    final String videoPath = widget.videoPath;
    final String email = widget.email;
    final String taskID = widget.taskID;
    final DateTime dateTime = DateTime.now();
    final String now = DateFormat('yyyyMMdd_kkmm').format(dateTime);
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('taskVideo/$email/$taskID/$now.mp4');
    // final UploadTask uploadTask = ref.putFile(File(filePath));
    // var status = await Permission.storage.status;
    // if (!status.isGranted) {
    //   await Permission.storage.request();
    // }
    final _flutterVideoCompress = FlutterVideoCompress();
    final info = await _flutterVideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );
    final UploadTask uploadTask = ref.putFile(info.file);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  Future<void> _waitNavigation() async {
    setState(() => _loading = true);
    await videoUpload();
    setState(() => _loading = false);
    await _showDialog(context, '送信完了');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(widget.email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckModel(),
      child: Consumer<CheckModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('動画確認'),
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
                      height: 450,
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      shape: CircleBorder(
                        side: BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        '再撮影',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      onPressed: () {
                        _waitNavigation();
                      },
                      color: Colors.teal,
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (!_loading) {
                            return Text(
                              '送信',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
