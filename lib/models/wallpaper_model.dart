class WallpaperModel{
   String photographer;
   String photographerurl;
   int photographerid;
  Srcmodel src;

  WallpaperModel({  this.photographer,this.photographerid,this.photographerurl,this.src});
  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(
      src:Srcmodel.fromMap(jsonData["src"]),
      photographer: jsonData["photographer"],
      photographerid: jsonData["photographer_id"],
      photographerurl: jsonData['photographer_url']
    );
  }
}

class Srcmodel{
   String original;
   String small;
   String portrait;

  Srcmodel({ this.original,this.portrait,this.small});

  factory Srcmodel.fromMap(Map<String,dynamic> jsonData){
    return Srcmodel(original: jsonData["original"],
    small: jsonData["small"],
    portrait: jsonData["portrait"]);
  }
}