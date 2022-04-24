import 'package:flutter/material.dart';

class VideoStatus with ChangeNotifier {
  late String _statusDir;



  String get waStatusDir => _statusDir;




  void waDir(String item){
    _statusDir = item;
    notifyListeners();
  }
}


  // List<String> _videoproviderPath = [];
  //
  //
  //
  // int get count => _videoproviderPath.length;
  //
  // List<String> get filepathVideoThumb => _videoproviderPath;
  //
  //
  // void videoFilePath(String item){
  //   _videoproviderPath.add(item);
  //   notifyListeners();
  // }
