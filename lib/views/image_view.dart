import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatefulWidget {

  final String imgUrl;
  ImageView({@ required this.imgUrl});
  

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
              child: Image.network(widget.imgUrl,fit: BoxFit.cover,)),
          ),

            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
      
              children: [
                InkWell(
                  onTap: (){
                    _save();
                    Fluttertoast.showToast(  
                    msg: 'Wallpaper saved in gallery!',  
                    toastLength: Toast.LENGTH_SHORT,  
                    gravity: ToastGravity.BOTTOM,  
                    backgroundColor: Colors.black45,  
                    textColor: Colors.white,
                  
    );  
                   //Navigator.pop(context);
                   
                  },
                  child: Stack(
                    children:[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                           color:Color(0xff1C1B1B).withOpacity(.8)
                
                        ),
                        width:MediaQuery.of(context).size.width/2,
                       
                      ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24,width: 1),
                        borderRadius: BorderRadius.circular(30),
                        gradient:LinearGradient(
                          colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF)
                          ]
                        )
                      ),
                      child:Column(
                        children: [
                          Text("Set wallpaper",style:TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold)),
                          Text("Image will be saved in gallery",style:TextStyle(fontSize: 10,color: Colors.white))
                        ],
                      )
                    ),]
                  ),
                ),
                 SizedBox(height: 16,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style:TextStyle(color: Colors.white))),
                SizedBox(height: 50,)
              ],
            ),

            )
        ],
    
      ),
      
    );
  }

   _save() async {
     if(Platform.isAndroid){
       await _askPermission();
     }
    
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.photos]);
    } else {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}