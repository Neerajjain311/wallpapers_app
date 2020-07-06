import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpapers_app/data/data.dart';
import 'package:wallpapers_app/model/wallpaper_model.dart';
import 'package:wallpapers_app/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=30",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    wallpapers = new List();
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (String searchQuery){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                searchQuery: searchController.text,
                              ),
                            ));  
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          hintText: "Search",
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getSearchWallpapers(searchController.text);
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
