import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/views/image_view.dart';

Widget brandName(){
  return Center(
    child: RichText(
    text: TextSpan(
      text: 'Wall',
      style: TextStyle(color: Color(0xffFF934F),fontSize: 22,fontWeight: FontWeight.bold),
      children: const <TextSpan>[
        TextSpan(text: 'paper', style: TextStyle(color: Colors.black45,fontSize: 22,fontWeight: FontWeight.bold)),
        TextSpan(text: 'ish', style: TextStyle(color: Color(0xffC2E812),fontWeight: FontWeight.bold,fontSize: 22)),
      ],
    ),
),
  );
}

Widget wallpaperList(List<WallpaperModel> wallpapers,context){
  return Container(
    child: GridView.count(
      childAspectRatio: 0.6,
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageView(imgUrl:wallpaper.src.portrait)));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
                    ),
            ),
          ),
        );

      }).toList(),
      ),
  );
}