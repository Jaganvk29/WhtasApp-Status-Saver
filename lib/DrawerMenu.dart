import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          children: <Widget>[
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 30),

                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black26 ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,


                  children: [
                    Text('STATUS SAVER',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,))
                  ],
                ),
              ),
            ),


            const SizedBox(
              height: 80,
            ),
            buildMenuItem(
                text: 'Share',
                icon: Icons.share,
                onPressed: () {
                  Share.share(
                      'Install Status Saver App To DownLoad Whatsapp Status - "SOON UPDATE LINK');
                }),
            const SizedBox(
              height: 30,
            ),
            buildMenuItem(
                text: 'Tutorial',
                icon: Icons.book,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: EdgeInsets.all(15),
                        titlePadding: EdgeInsets.all(15),
                        title: Text(
                          'Tutorial',
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          'Check The Status Image\n Or Videos in Whatsapp \n\n Come Back To App Click\n Any Image Or Videos To View \n\n  Click Download Button  \n\n  The Image/Video Saved To Gallery',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Okay'))
                        ],
                      ));
                }),
            const SizedBox(
              height: 30,
            ),
            buildMenuItem(
                text: 'About',
                icon: Icons.info_rounded,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: EdgeInsets.all(15),
                        titlePadding: EdgeInsets.all(15),
                        title: Text(
                          'About',
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          'Version : 1.0.0',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Okay'))
                        ],
                      ));
                }),
          ],
        ),
      ),
    );
  }
}


Widget buildMenuItem(
    {required String text, required IconData icon, required onPressed}) {
  const color = Colors.white;
  const hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    hoverColor: hoverColor,
    onTap: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    tileColor: Colors.blue,
  );
}