import 'package:flutter/material.dart';
import 'package:saf/saf.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import './ImageViewer.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

class Images extends StatefulWidget {
  const Images({Key? key}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> with AutomaticKeepAliveClientMixin<Images> {
  @override
  bool get wantKeepAlive => true;




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



      saf = Saf(directory);


      getcacheimage();
    }









    getversion();




    super.initState();

  }

  var sdkInt;

  // SAF PERMISSION WHATSAPP HIDDEN STATUSES FOLDER





  //CACHED FILES

  getcacheimage() async {
    var isSync = await saf.sync();
    if (isSync as bool) {
      var _paths = await saf.getCachedFilesPath();
      loadImage(_paths);
    }






  }

  var _paths = [];
  loadImage(paths, {String k = ""}) {
    var tempPaths = [];
    for (String path in paths) {
      if (path.endsWith(".jpg")) {
        tempPaths.add(path);
        _paths.add(path);
      }
    }
    if (k.isNotEmpty) tempPaths.add(k);
    _paths = tempPaths;
    setState(() {});
  }
  void getversion() async{
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      // print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }
  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: ()=>getcacheimage(),
          child: Container(
            padding: EdgeInsets.all(5),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                cacheExtent: 9999,
                itemCount: _paths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.all(7),

                    color: Colors.black54,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageViewer(
                                  photourl: _paths[index],
                                )));
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(_paths[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
