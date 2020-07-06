import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers_app/model/wallpaper_model.dart';
import 'package:wallpapers_app/views/image_view.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      //SizedBox(height: 20,),
      Text(
        'Pixel ',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: Colors.indigo[600],
          letterSpacing: 1.2,
        ),
      ),

      Icon(
        Icons.photo_library,
        color: Colors.redAccent,
      ),

      Text(
        ' Perfect',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: Colors.indigo[600],
          letterSpacing: 1.2,
        ),
      )
    ],
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      primary: true,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.62,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgUrl: wallpaper.src.portrait,
                  ),
                ),
              );
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
