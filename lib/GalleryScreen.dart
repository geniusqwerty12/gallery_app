import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_app_1/my_icons_icons.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {

  // List of images in the assets to be displayed
  List<String> imageAssetList = ["image-1.jpg", "image-2.jpg","image-3.jpg","image-4.jpg","image-5.jpg","image-6.jpg"];

  // 23 File and Memory Images
  File selectedImage;
  Uint8List memoryImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        leading: Container(
          // child: Icon(Icons.motion_photos_pause)
          child: Icon(MyIcons.emo_unhappy)
        ),
        // list of wigets
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              // accept an image to be rendered
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          )
        ],
        // remove the appbar shadow
        elevation: 0,
      ),
      // app content
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            // Text section
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Text(
                    "UnSplash",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      fontFamily: "Montserrat"
                    )
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Beautiful, free photos"
                  )
                ]
              ),
            ),
          
          // search bar section
           Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Photo",
                  border: InputBorder.none,
                  fillColor: Colors.grey,
                  icon: Icon(Icons.ac_unit_sharp)
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          
            // List the images
            Expanded(
              // Using ListView builder
              // child: ListView.builder(
              //   itemCount: imageAssetList.length,
              //   itemBuilder: (BuildContext ctx, index){
              //     // return Text(imageAssetList[index]);
              //     return ClipRRect(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       // Asset image
              //       // child: Image.asset("assets/images/" + imageAssetList[index]),
              //       child: Image.asset("assets/images/"+ imageAssetList[index]),
              //     );
              //   }
              // )
              
              // Grid view
              child: GridView.builder(
                itemCount: imageAssetList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // number of columns
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ), 
                itemBuilder: (BuildContext ctx, index){
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // Asset image
                    child: Image.asset("assets/images/"+ imageAssetList[index]),
                  );
                },
              )
            ),

             // 28 render the file and memory button
            buildFileButton(),

            Row(
              children: [
                // 29 Check first if the File is selected
                if(selectedImage != null)  Image.file(selectedImage, width: 100, height: 100),
                // 32 check if the byte variable is not null
                if(memoryImage != null)  Image.memory(memoryImage, width: 100, height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 23 Create the upload image function
  Widget buildFileButton(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        child: Text("Select a File"),
        onPressed: () async {
          // 24 add the image picker
          final picker = ImagePicker();
          // 25 get the image file from the gallery
          final pickedFile = await picker.getImage(source: ImageSource.gallery);

          // 26 check if the returned file is null
          // This means that the user cancelled the image picking
          if(pickedFile == null) return; // terminate the function

           // 27 get the path directory of selected image
          final file = File(pickedFile.path);
          // 31 get the file bytes
          final bytes = await file.readAsBytes();

          setState(() {
            // File
            selectedImage = file; 
            // 32 stored it in the state variable       
            // Bytes    
            memoryImage = bytes;
          });

        }
      )
    );
  }
}