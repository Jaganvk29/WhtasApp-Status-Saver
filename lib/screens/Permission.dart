
import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import './Home.dart';

class PermissionScreen extends StatefulWidget {
  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  var storageAcess ;
  var safStorageAccess ;

  // SAF PERMISSION WHATSAPP HIDDEN STATUSES FOLDER


  late Saf saf;


  // var _paths = [];

  @override
  void initState() {





    getsafpermission();
    // getStoragePermission();
    // isSafStorageAccess();
    isStorageAccess();
    pageChange();




    super.initState();

  }

  bool? isGranted;

  void isSafStorageAccess() async {





    if (isGranted != null && isGranted == true) {

      setState(() {
        safStorageAccess = true;
      });
      // print("ITS GRANTED");
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

  //PHOTOS AND MEDIA PERMISSION
   var storage;

  void isStorageAccess() async{

    var status = await Permission.storage.status;
    print(status);

    if (status == PermissionStatus.granted) {
      setState(() {
        storageAcess = true;
      });

      // print("PERMISSION GRANTED");
    } else {
      setState(() {
        storageAcess = false;
      });

      // print("PERMISSION DENIED");
      // getStoragePermission();
    }
  }

  void getStoragePermission() async {
     storage = await Permission.storage.request().isGranted;

     isStorageAccess();
     // print(storageAcess);
  }


  void pageChange() async {
    if(safStorageAccess == true && storageAcess == true){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );

    }


  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              // decoration: BoxDecoration(color: Colors.red),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "ALLOW PERMISSION ",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  if (!storageAcess == true)
                    ElevatedButton(
                          onPressed: getStoragePermission,
                          child: const Text("GRANT STORAGE PERMISSION")),
                  if (!safStorageAccess == true)
                  ElevatedButton(
                      onPressed: getsafpermission,
                      child: const Text("GRANT FILE PERMISSION")),

                  if(safStorageAccess == true && storageAcess == true)
                    ElevatedButton(
                        onPressed: pageChange,
                        child: const Text("GO HOME")),




                ],
              )),
        )
      ],
    );
  }
}
