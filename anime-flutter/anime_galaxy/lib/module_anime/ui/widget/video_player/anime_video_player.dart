import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimeVideoPlayer extends StatefulWidget {
  const AnimeVideoPlayer(this.link);
  final String link;

  @override
  State<StatefulWidget> createState() {
    return _AnimeVideoPlayerState(link);
  }
}

class _AnimeVideoPlayerState extends State<AnimeVideoPlayer> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  final String link;

  _AnimeVideoPlayerState(this.link);

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  void pause() {
    if (_chewieController != null) {
      if (_chewieController.isPlaying) {
        _chewieController.pause();
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(link);
    await _videoPlayerController1.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      // Try playing around with some of these other options:

      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return _chewieController != null &&
            _chewieController.videoPlayerController.value.initialized
        ? VisibilityDetector(
          key: ObjectKey(this),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction < 50) {
              pause();
            }
          },
          child: AspectRatio(
            aspectRatio: 16/9,
            child: Chewie(
                controller: _chewieController,
              ),
          ),
        )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
  }
}
