import 'package:first_test_4/description_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'camera_page.dart';

class DescriptionPage extends StatefulWidget {
  final String taskName;
  final String taskID;
  final String email;

  DescriptionPage(this.taskName, this.taskID, this.email);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DescriptionModel(),
      child: Consumer<DescriptionModel>(
        builder: (context, model, child) {
          model.taskName = widget.taskName;
          model.taskID = widget.taskID;
          model.email = widget.email;
          model.getTaskInformation();
          return Scaffold(
            appBar: AppBar(
              title: Text(model.taskName),
              backgroundColor: Colors.teal,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '説明',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: model.descriptionTexts
                          .map(
                            (text) => model.itemizedTextRow(text),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 350,
                    child: FutureBuilder(
                      future: model.initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: model.controller.value.aspectRatio,
                            child: VideoPlayer(model.controller),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      model.playPause();
                    },
                    child: SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow),
                          Icon(Icons.pause),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CameraPage(model.taskID, model.email)),
                );
              },
              label: const Text('撮影開始'),
              backgroundColor: Colors.teal,
            ),
          );
        },
      ),
    );
  }
}
