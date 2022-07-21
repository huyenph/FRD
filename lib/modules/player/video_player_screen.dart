import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends BaseState<VideoPlayerScreen> {
  late VideoPlayerController _networkController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    _networkController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: videoPlayer(),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;

  void initPlayer() async {
    _networkController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
    // _networkController.setLooping(true);
    // await _networkController.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _networkController,
        autoPlay: true,
        looping: true,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: UpmText(
              text: errorMessage,
            ),
          );
        });
  }

  Widget videoPlayer() => Chewie(
        controller: _chewieController,
      );

  Future<ClosedCaptionFile> _loadCaption() async {
    final String fileContents = await DefaultAssetBundle.of(context).loadString(
      'assets/bumble_bee_caption.vtt',
    );
    return WebVTTCaptionFile(fileContents);
  }
}
