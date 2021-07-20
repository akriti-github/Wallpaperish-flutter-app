import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';

class Category extends StatefulWidget {
  final String categoryname;
  Category({this.categoryname});
  

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController searchController=new TextEditingController();

  List<WallpaperModel> wallpapers=[];
  searchWallpapers(String query)async{
    var response = await http.get( Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),headers:{
      "Authorization":apiKey
    });

    Map<String,dynamic> jsondata=jsonDecode(response.body);
    jsondata["photos"].forEach((element){
      WallpaperModel wallpaperModel=new WallpaperModel();
      wallpaperModel= WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);

    });
    setState(() {
     
      
    });

  }


  @override
  void initState() {
    searchWallpapers(widget.categoryname);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
    text: TextSpan(
      text: 'Wall',
      style: TextStyle(color: Color(0xffFF934F),fontSize: 22,fontWeight: FontWeight.bold),
      children: const <TextSpan>[
        TextSpan(text: 'paper', style: TextStyle(color: Colors.black45,fontSize: 22,fontWeight: FontWeight.bold)),
        TextSpan(text: 'ish', style: TextStyle(color: Color(0xffC2E812),fontWeight: FontWeight.bold,fontSize: 22)),
      ],
    ),
),
        elevation: 0.0,
      ),
       body: SingleChildScrollView(
        child: Container(
          child: Column(
          children: [
           SizedBox(height: 16,),
          wallpaperList(wallpapers, context)
    ],),),),);
      
  }
}