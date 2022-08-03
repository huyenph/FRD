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
    _networkController = VideoPlayerController.asset(
      'assets/videos/packages_video_player_video_player_example_assets_Butterfly-209.webm',
      closedCaptionFile: _loadCaption(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    // _networkController.setLooping(true);
    // await _networkController.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _networkController,
        autoPlay: true,
        looping: true,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        // allowFullScreen: true,
        // subtitle: Subtitles([
        //   Subtitle(
        //     index: 0,
        //     start: Duration.zero,
        //     end: const Duration(seconds: 3),
        //     text: 'Hello from subtitles',
        //   ),
        //   Subtitle(
        //     index: 1,
        //     start: const Duration(seconds: 4),
        //     end: const Duration(seconds: 7),
        //     text: 'Whats up? :)',
        //   ),
        // ]),
        // subtitleBuilder: (context, subtitle) => Container(
        //       padding: const EdgeInsets.all(10.0),
        //       child: Text(
        //         subtitle,
        //         style: const TextStyle(color: Colors.white),
        //       ),
        //     ),
        additionalOptions: (context) {
          return <OptionItem>[
            OptionItem(
              onTap: () => debugPrint('My option works!'),
              iconData: Icons.chat,
              title: 'My localized title',
            ),
            OptionItem(
              onTap: () => debugPrint('Another option working!'),
              iconData: Icons.chat,
              title: 'Another localized title',
            ),
          ];
        },
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
      'assets/captions/bumble_bee_captions.vtt',
    );
    return WebVTTCaptionFile(fileContents);
  }
}
