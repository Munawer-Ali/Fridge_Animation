import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../core/constants/app_assets.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
    this.onVideoStarted,
  });

  final ValueChanged<Duration>? onVideoStarted;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _controller;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.videoFrigeAnimation)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        _controller.setPlaybackSpeed(3.0);
        // _controller.play();
      }).catchError((Object e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load video: $e')),
          );
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  _buildBody();
  }

  Widget _buildBody() {
    if (_controller.value.isInitialized) {
      return GestureDetector(
        onTap: () {
          if (_isPlaying) {
            return;
          }
          setState(() => _isPlaying = !_isPlaying);
          widget.onVideoStarted?.call(_controller.value.duration);
          _controller.play();
        },
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );
    }
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading video...'),
      ],
    );
  }
}
