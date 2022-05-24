import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAlbumHome extends StatefulWidget {
  const PhotoAlbumHome({Key? key}) : super(key: key);

  @override
  State<PhotoAlbumHome> createState() => _PhotoAlbumHomeState();
}

class _PhotoAlbumHomeState extends State<PhotoAlbumHome> {
  File? singleImage;
  final singlePicker = ImagePicker();
  final multiPicker = ImagePicker();
  List<XFile>? images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "PHOTO ALBUM",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: images!.isEmpty ? 1 : images!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      ),
                      child: images!.isEmpty
                          ? Icon(
                              CupertinoIcons.camera,
                              color: Colors.grey.withOpacity(0.5),
                            )
                          : Image.file(
                              File(images![index].path),
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              TextButton(
                onPressed: () => getMultiImages(),
                child: Text("Add Photo"),
                style: TextButton.styleFrom(
                  primary: Colors.black, //Text Color
                  backgroundColor: Colors.grey, //Button Background Color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getMultiImages() async {
    final List<XFile>? selectedImages = await multiPicker.pickMultiImage();
    setState(() {
      if (selectedImages!.isNotEmpty) {
        images!.addAll(selectedImages);
      } else {
        print("No images selected");
      }
    });
  }
}
