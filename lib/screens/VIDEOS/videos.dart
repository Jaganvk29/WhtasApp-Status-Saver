import 'package:flutter/material.dart';
import 'package:saf/saf.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';


import 'package:device_info_plus/device_info_plus.dart';

import '../../Providers/VideoProvider.dart';
import 'package:provider/provider.dart';

import './VideoViewer.dart';

class VIDEOS extends StatefulWidget {
  const VIDEOS({Key? key}) : super(key: key);

  @override
  State<VIDEOS> createState() => _VIDEOSState();
}

class _VIDEOSState extends State<VIDEOS> with AutomaticKeepAliveClientMixin<VIDEOS> {
  @override
  bool get wantKeepAlive => true;

  // void updateKeepAlive() {
  //   if (wantKeepAlive) {
  //     if (_keepAliveHandle == true)
  //       _ensureKeepAlive();
  //   } else {
  //     if (_keepAliveHandle != null)
  //       _releaseKeepAlive();
  //   }
  // }


  // SAF PERMISSION WHATSAPP HIDDEN STATUSES FOLDER
  var directory = "Android/Media/com.whatsapp/WhatsApp/Media/.Statuses";

  late Saf saf;

  @override
  void initState() {

    void getversion() async{
      var directory;

      if (Platform.isAndroid) {

        var androidInfo = await DeviceInfoPlugin().androidInfo;

        int? sdkInt = androidInfo.version.sdkInt;
        print(sdkInt);


        if(sdkInt! > 29){
          directory =  "Android/Media/com.whatsapp/WhatsApp/Media/.Statuses";
          print('ANDROID SDK VERSION ${sdkInt}');

        } else {
          directory = "WhatsApp/Media/.Statuses";
          print('ANDROID SDK VERSION ${sdkInt}');


        }



      }


      context.read<VideoStatus>().waDir(directory);
      saf = Saf(directory);

      getcacheVideo();

    }







    getversion();

    super.initState();
  }

  //CACHED FILES
  getcacheVideo() async {
    var isSync = await saf.sync();
    if (isSync as bool) {
      var _paths = await saf.getCachedFilesPath();
      loadVideo(_paths);
    }
  }

  var _videopaths = [];
  var _videothumbpaths = [];

  loadVideo(paths, {String k = ""}) async {
    var tempPaths = [];
    for (String path in paths) {
      if (path.endsWith(".mp4")) {
        tempPaths.add(path);
        _videopaths.add(path);

      }
    }
    if (k.isNotEmpty) tempPaths.add(k);
    _videopaths = tempPaths;
    setState(() {});
  }

  ThumbNailGenerator(videoUrl) async {
    final thumb = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      imageFormat: ImageFormat.PNG,
      quality: 5,
    );
    return thumb;
  }
  //context.watch<Status>().filepathiamges[index]
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: ()=>getcacheVideo(),
          child: Container(
            padding: EdgeInsets.all(5),
            child:

            GridView.builder(

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _videopaths.length,
                cacheExtent: 9999,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.all(7),
                    color: Colors.black54,
                    child: InkWell(

                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoViewer(Videourl:_videopaths[index] ,

                                )));
                      },
                      child: FutureBuilder(
                          future: ThumbNailGenerator(_videopaths[index]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(snapshot.data.toString()),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  child: Text("THERES IS NO DATA"),
                                );
                              }
                            }
                            return Center(child: Text(""));
                          }),
                    ),
                  );
                }),

          ),
        ),
      ),
    );
  }
}

// return Container(
//       child: Center(
//         child: ElevatedButton(
//           onPressed: () => print(_videothumbpaths),
//           child: Text("GET VIDEO THUMB NAIL"),
//         ),
//       ),
//     );





