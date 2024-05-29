import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/screens/curd.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerr extends StatefulWidget {
  const ImagePickerr({super.key});

  @override
  State<ImagePickerr> createState() => _ImagePickerrState();
}

class _ImagePickerrState extends State<ImagePickerr> {
  XFile? pick;
  File? image;
  Future<void> ProfileImg()async{
    if(image!=null){
      try {
        final ref = FirebaseStorage.instance
        .ref()
        .child('Profile_image')
        .child(DateTime.now().microsecondsSinceEpoch.toString());
      await ref.putFile(image!);
      final imageurl = await ref.getDownloadURL();  
      Navigator.push(context, MaterialPageRoute(builder: (context) => TodoScreen(image:image),));
      } 
      
      catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: 
                              Text('error'),
                          ),
                        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(
            
            child: Column(
              children: [
                InkWell(
                  onTap: () async{
                    ImagePicker picked = ImagePicker();
                      pick = await picked.pickImage(source: ImageSource.gallery);
                
                      setState(() {
                        image = File(pick!.path);
                      });
                  },
                  child: CircleAvatar(
                    backgroundImage: image != null? FileImage(image!):null,
                  ),
                ),




                ElevatedButton(
                    onPressed: () async {
                      ProfileImg();
                    },
                    child: Text('data')
                    ),
              ],
            ),
                
          ),
        

        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
            // image: DecorationImage(image: NetworkImage(productData))
          ),
        )
        ],
      ),
       
    );
  }
}
