import 'package:flutter/material.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../../Providers/VideoProvider.dart';
import 'package:provider/provider.dart';
import './IMAGES/Images.dart';
import './VIDEOS/videos.dart';
import 'package:saf/saf.dart';
import '../DrawerMenu.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var directory ="WhatsApp/Media/.Statuses";
  var storageAcess;
  var safStorageAccess;
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


      getStoragePermission();
      getsafpermission();

    }

    getversion();







    super.initState();

  }



  // void getversion() async{
  //   if (Platform.isAndroid) {
  //     var androidInfo = await DeviceInfoPlugin().androidInfo;
  //     var release = androidInfo.version.release;
  //     sdkInt = androidInfo.version.sdkInt;
  //     var manufacturer = androidInfo.manufacturer;
  //     var model = androidInfo.model;
  //     // print('Android $release (SDK $sdkInt), $manufacturer $model');
  //     // Android 9 (SDK 28), Xiaomi Redmi Note 7
  //   }
  // }


  void grantPermission() {
    getStoragePermission();
    getsafpermission();
  }

  bool? isGranted;

  void isSafStorageAccess() async {
    if (isGranted != null && isGranted == true) {
      setState(() {
        safStorageAccess = true;
      });
      print("ITS GRANTED");
    } else {
      setState(() {
        safStorageAccess = false;
      });
      // failed to get the permission
      // print("ITS DENIED" + '${safStorageAccess}');
    }
  }

  void getsafpermission() async {
    isGranted = await saf.getDirectoryPermission(isDynamic: false);
    isSafStorageAccess();

    // print("ITS FROM SAF STORAGE AFER THE SA IF ELSE" + '${safStorageAccess}');
  }

  //=======================================================

  //PHOTOS AND MEDIA PERMISSION
  var storage;

  void isStorageAccess() async {
    var status = await Permission.storage.status;
    print(status);

    if (status == PermissionStatus.granted) {
      print("ACCESS GRANTED");
      // print("PERMISSION GRANTED");
    } else {
      print("ACCESS DENIED");

      // print("PERMISSION DENIED");
      // getStoragePermission();

    }
      var mediapermission = await Permission.accessMediaLocation;
    if (mediapermission == PermissionStatus.granted) {
      print("ACCESS GRANTED");
      // print("PERMISSION GRANTED");
    } else {
      print("ACCESS DENIED");

      // print("PERMISSION DENIED");
      // getStoragePermission();

    }


  }

  void getStoragePermission() async {
    storage = await Permission.storage.request().isGranted;
    isStorageAccess();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerMenu(),
        appBar: AppBar(
          title: const Text("STATUS SAVER"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "IMAGES"),
              Tab(text: "VIDEOS"),
              Tab(text: "SAVED"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //IMAGES TAB

            if (isGranted == true && storage == true)
              Images()
            else
              Center(
                child: ElevatedButton(
                  onPressed: grantPermission,
                  child: const Text("GRANT PERMISSION"),
                ),
              ),

            //VIDEOS TAB

            if (isGranted == true && storage == true)
            VIDEOS()
            else
              Center(
                child: ElevatedButton(
                  onPressed: grantPermission,
                  child: const Text("GRANT PERMISSION"),
                ),
              ),

            //SAVED TAB
            if (isGranted == true && storage == true)
              Center(child: Text("SAVED SECTION"),)
            else
              Center(
                child: ElevatedButton(
                  onPressed: grantPermission,
                  child: const Text("GRANT PERMISSION"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
