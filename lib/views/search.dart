import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;
class Search extends StatefulWidget {
  final String searchquery;
  Search({this.searchquery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

   List<WallpaperModel> wallpapers=[];

   TextEditingController searchController=new TextEditingController();
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
    searchWallpapers(widget.searchquery);
    super.initState();
     searchController.text=widget.searchquery;

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
            Container(
              decoration: BoxDecoration(
                color: Color(0xffD2DAD2),borderRadius:BorderRadius.circular(32)),
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search Wallpaper",
                        border: InputBorder.none,
                      
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(
                          searchquery: searchController.text,
                        )
                        ));
                      
                      //searchWallpapers(searchController.text);
                     
                    },
                    child: 
                    Container(child: Icon(Icons.search))),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                         Text("Made by "),
                          Text("Akriti Jain ", style: TextStyle(color: Color(0xffFF934F),fontWeight: FontWeight.bold),)
              ],
            ),
          ),
       SizedBox(height: 16,),
          wallpaperList(wallpapers, context)
    ],),),),);
  }
}