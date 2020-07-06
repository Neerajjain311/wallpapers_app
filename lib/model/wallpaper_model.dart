class WallpaperModel{
  
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  WallpaperModel({this.src, this.photographer, this.photographerId, this.photographerUrl});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData){
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographerUrl: jsonData["photographer_url"],
      photographer: jsonData["photographer"],
      photographerId: jsonData["photographer_id"],
    );
  }
}

class SrcModel{

  String original;
  String small;
  String portrait;
  SrcModel({this.original, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData){
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"], 
    );
  }

}