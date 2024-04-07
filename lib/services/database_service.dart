import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';

class DatabaseService{

  final  CollectionReference postCollection= FirebaseFirestore.instance.collection("post_data");

  Future createPost(String url, String title)async{
    try {
      await postCollection.add({
        "url": url,
        "title": title,
      });
      if (kDebugMode) {
        print("Post created successfully!");
      }
    } catch (e) {
      print("Error creating post: $e");

    }
  }


  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');

      await ref.putFile(imageFile);

      String imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase: $e');

      return null;
    }
  }

}