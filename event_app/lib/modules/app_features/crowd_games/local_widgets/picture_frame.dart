import 'package:event_app/config/theme/colors.dart';
import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';

class PictureFrame extends StatefulWidget {
  const PictureFrame({ Key? key }) : super(key: key);

  @override
  _PictureFrameState createState() => _PictureFrameState();
}

class _PictureFrameState extends State<PictureFrame> {
  // CameraController? controller;
  // String? imagePath;
  // XFile? imageFile;



  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('picture frame been tapped');



      },
      child: Container(
        width: 82,
        height: 60,
        decoration: BoxDecoration(
            color: textbox_background, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(5),
        child: Container(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.image,
            color: navigationrail_background,
          ),
        ),
      ),
    );
  }
}
