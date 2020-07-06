import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({this.imgUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: widget.imgUrl,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(widget.imgUrl, fit: BoxFit.cover),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _save();
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 52,
                      width: MediaQuery.of(context).size.width / 1.9,
                      //color: Colors.black54.withOpacity(0.8),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.2),
                        //border: Border.all(color: Colors.white54),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width / 1.9,
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                          //border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.blueGrey.withOpacity(0.7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal[100].withOpacity(0.5),
                              blurRadius: 3.0, // soften the shadow
                              spreadRadius: 0.5, //extend the shadow
                              
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Download",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Image will be saved in Gallery",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.5,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 26,
                  width: MediaQuery.of(context).size.width / 3.8,
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    ));
  }

  _save() async {
    await _askPermission();
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    Toast.show(
      "Image Saved !",
      context,
      gravity: Toast.BOTTOM,
      duration: Toast.LENGTH_SHORT,
      backgroundColor: Colors.teal[300].withOpacity(0.88),
    );
    Navigator.pop(context);
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    
  }

  _askPermission() async {
    PermissionStatus status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (status != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    }
  }
}
