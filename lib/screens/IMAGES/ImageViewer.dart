import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:media_scanner/media_scanner.dart';

String appDirectoryImg =
    "/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppImages";

class ImageViewer extends StatelessWidget {
  final isDialOpen = ValueNotifier(false);

  String? photourl;

  ImageViewer({@required this.photourl});

  downloadImage() async {
    String? loadMediaMessage;

    Directory? directory =
        await getExternalStorageDirectory(); // /storage/emulated/0
    File OriginalVid = File(photourl.toString());
    String Vidwithoutext =
        path.basenameWithoutExtension(OriginalVid.toString());

    print(directory);

    if (!Directory(
            '/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppImages')
        .existsSync()) {
      (Directory('/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppImages')
          .createSync(recursive: true));
    }
    await OriginalVid.copy(appDirectoryImg + '/' + Vidwithoutext + '.jpg');

    try {
      loadMediaMessage = await MediaScanner.loadMedia(
          path: "/storage/emulated/0/Pictures/waMyStatusSaver/WhatsAppImages/" +
              Vidwithoutext +
              ".jpg");
    } on PlatformException {
      loadMediaMessage = 'Failed to get platform version.';
    }

    print(loadMediaMessage);
  }

  final snackBarr = SnackBar(
    content: const Text('Image Saved To Gallery :)'),
    duration: Duration(seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;

          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        child: Stack(
                          children: [
                            PhotoView(
                              imageProvider: FileImage(File(photourl!)),
                              minScale: PhotoViewComputedScale.contained * 0.8,
                              maxScale: PhotoViewComputedScale.covered * 2,
                              backgroundDecoration:
                                  BoxDecoration(color: Colors.black26),
                            ),
                            Positioned(
                              bottom: 50,
                              right: 10,
                              child: FloatingActionButton(
                                  onPressed: () {},
                                  child: SpeedDial(
                                    openCloseDial: isDialOpen,
                                    animatedIcon: AnimatedIcons.menu_close,
                                    spacing: 12,
                                    spaceBetweenChildren: 12,
                                    children: [
                                      SpeedDialChild(
                                          child: Icon(Icons.save),
                                          label: "SAVE",
                                          onTap: () => {
                                                downloadImage(),
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBarr)
                                              }),
                                      SpeedDialChild(
                                          child: Icon(Icons.share),
                                          label: "SHARE")
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
