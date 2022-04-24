import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isloop;
  final double aspectratio;
  final String videourlpath;
  VideoPlayer(
      {required this.isloop,
      required this.videoPlayerController,
      required this.aspectratio
      ,required this.videourlpath});


  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {


  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videourlpath));
    _future = initVideoPlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initVideoPlayer() async {
    await _controller.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: _controller.value.aspectRatio,
          autoPlay: true,
          looping: true,
          placeholder: buildPlaceholderImage()
      );
    });
  }

  buildPlaceholderImage() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return buildPlaceholderImage();

            return Center(
              child: Chewie(controller: _chewieController,),
            );
          },
        )
    );
  }
}
