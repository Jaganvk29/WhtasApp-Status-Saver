import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart' as vidplay;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import './VideoPlayerController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:media_scanner/media_scanner.dart';

String appDirectoryImg =
    "/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppVideos";

class VideoViewer extends StatefulWidget {
  String? Videourl;

  VideoViewer({@required this.Videourl});
  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  downloadVideo() async {
    String? loadMediaMessage;

    Directory? directory =
        await getExternalStorageDirectory(); // /storage/emulated/0
    File OriginalVid = File(widget.Videourl.toString());
    String Vidwithoutext =
        path.basenameWithoutExtension(OriginalVid.toString());

    print(directory);

    if (!Directory(
            '/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppVideos')
        .existsSync()) {
      (Directory('/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppVideos')
          .createSync(recursive: true));
    }
    await OriginalVid.copy(appDirectoryImg + '/' + Vidwithoutext + '.mp4');

    try {
      loadMediaMessage = await MediaScanner.loadMedia(
          path: "/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppVideos/" +
              Vidwithoutext +
              ".mp4");
    } on PlatformException {
      loadMediaMessage = 'Failed to get platform version.';
    }

    print(loadMediaMessage);
  }

  final snackBarr = SnackBar(
    content: const Text('Video Saved To Gallery :)'),
    duration: Duration(seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            VideoPlayer(
              aspectratio: 1.0,
              isloop: true,
              videourlpath: widget.Videourl.toString(),
              videoPlayerController: vidplay.VideoPlayerController.file(
                File(widget.Videourl.toString()),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 10,
              child: FloatingActionButton(
                  onPressed: () {},
                  child: SpeedDial(
                      // openCloseDial: isDialOpen,
                      animatedIcon: AnimatedIcons.menu_close,
                      spacing: 12,
                      spaceBetweenChildren: 12,
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.save),
                          label: "SAVE",
                          onTap: () => {
                            downloadVideo(),
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarr)
                          },
                        ),
                        SpeedDialChild(child: Icon(Icons.share), label: "SHARE")
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
