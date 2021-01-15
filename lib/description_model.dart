import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DescriptionModel extends ChangeNotifier {
  String taskName = '';
  String taskID = '';
  String email;

  List<Text> descriptionTexts;
  VideoPlayerController controller;

  final fontSize = 18.0;
  Future<void> initializeVideoPlayerFuture;

  Future getTaskInformation() async {
    switch (taskID) {
      case 'fingerTapping':
        this.descriptionTexts = [
          Text(
            '動画を参考に、指タッピングの様子を横から撮影してください',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
          Text(
            '最低10回のタッピングを撮影してください',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
        ];
        this.controller = VideoPlayerController.asset('assets/FT2.mp4');
        break;
      case 'legTapping':
        this.descriptionTexts = [
          Text(
            '動画を参考に、脚タッピングの様子を横から撮影してください',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
          Text(
            '最低10回のタッピングを撮影してください',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
        ];
        this.controller = VideoPlayerController.asset('assets/LT.mp4');
        break;
      case 'walking':
        this.descriptionTexts = [
          Text(
            '動画を参考に、歩行の様子を横から撮影してください',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
          Text(
            '最低2ステップ歩いてください',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
        ];
        this.controller = VideoPlayerController.asset('assets/WK.mp4');
        break;
      case 'other':
        this.descriptionTexts = [
          Text(
            '未実装',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
        ];
        this.controller = VideoPlayerController.asset('assets/Ot.mp4');
        break;
    }

    this.initializeVideoPlayerFuture = controller.initialize();
    controller.setLooping(true);
  }

  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  Future playPause() async {
    if (this.controller.value.isPlaying) {
      this.controller.pause();
    } else {
      this.controller.play();
    }
  }

  Widget itemizedTextRow(Text text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '・',
            style: TextStyle(
              fontSize: this.fontSize,
            ),
          ),
          Expanded(child: text),
        ],
      ),
    );
  }
}
