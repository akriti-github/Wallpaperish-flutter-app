import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/categories_model.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/views/category.dart';
import 'package:wallpaper/views/image_view.dart';
import 'package:wallpaper/views/search.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories =[];
  List<WallpaperModel> wallpapers=[];

  TextEditingController searchController=new TextEditingController();

  getWallpapers()async{
    var response = await http.get( Uri.parse("https://api.pexels.com/v1/curated?per_page=30&page=1"),headers:{
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
    getWallpapers();
    categories=getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
            Container(
              height: 80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount:categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal ,
                itemBuilder: (context,index){
                return CategoryTile(title: categories[index].categoryName, imgURL: categories[index].imgURL);
              }),
            ),
            SizedBox(height: 16,),
            wallpaperList(wallpapers, context)
           
            ],
          ),),
        ),
      ),
      
    );
  }
}
class CategoryTile extends StatelessWidget {

  final String imgURL,title;
  CategoryTile({this.title,this.imgURL});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Category(
          categoryname: title.toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:Image.network(imgURL,height: 50,width: 100, fit: BoxFit.cover,),
          ),
            Container(
              color: Colors.black38,
              alignment: Alignment.center,
              height: 50,
              width: 100,
              
              child:Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),) ,)
        ],),
        
      ),
    );
  }
}