import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers_app/data/data.dart';
import 'package:wallpapers_app/model/categories_model.dart';
import 'package:wallpapers_app/model/wallpaper_model.dart';
import 'package:wallpapers_app/views/image_view.dart';
import 'package:wallpapers_app/views/search.dart';
import 'package:wallpapers_app/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapers_app/views/category.dart';

int loadImages = 30;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<CategoryModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();
  int loadImages = 20;

  getTrendingWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=art&per_page=$loadImages",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);

    });

    setState(() {});
  }

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadImages = loadImages + 10;
          getTrendingWallpapers();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
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
                        onSubmitted: (String searchQuery) {
                          if(searchController.text != "")
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(
                                  searchQuery: searchController.text,
                                ),
                              )
                            );
                          }
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
                        if(searchController.text != "")
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                searchQuery: searchController.text,
                            ),
                          ));
                        }
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 58,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      title: categories[index].categoryName,
                      imgUrl: categories[index].imgUrl,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 18,
              ),
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, title;
  CategoryTile({@required this.imgUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Category(
              categoryName: title.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageView()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  height: 58,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 58,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
