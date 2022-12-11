import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:Homeplex/utils/utils.dart';
import 'package:Homeplex/watertanker/driver/modeltankerupload.dart';
import 'package:Homeplex/watertanker/driver/tankerdriverwidgets.dart';
import 'package:Homeplex/watertanker/ordertanker.dart';

class Watertankerupload {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid = Utils().getUid();
  Future<String> uploadtankerToDatabase({
    required Uint8List? image,
    required String vehicalname,
    required int kmprice,
    required String driverphoneno,
    required String id,
    required String post,
    required String capacity,
    required String drivername,
    required String licienceno,
    required String targetarea,
  }) async {
    vehicalname.trim();
    String output = "Something went wrong";
    if (image != null && vehicalname != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);

        WaterTankeruploadmodel product = WaterTankeruploadmodel(
          url: url,
          vehicalname: vehicalname,
          uid: uid,
          kmprice: kmprice,
          driverphoneno: driverphoneno,
          post: post,
          id: id,
          drivername: drivername,
          capacity: capacity,
          licienceno: licienceno,
          targetarea: targetarea,
        );

        await firebaseFirestore
            .collection("tanker")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("tanker").child(uid).child('a');
    UploadTask uploadToask = storageRef.putData(image);
    TaskSnapshot task1 = await uploadToask;
    return task1.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsByCatogary(
      String driverid, String post) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("tankerOrder")
        //.where("district", isEqualTo: district)
        .where("driverid", isEqualTo: driverid)
        .where("post", isEqualTo: post)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      TankerOrder model =
          TankerOrder.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(WaterTankerDriverOrderWidets(transportOrder: model));
    }
    return children;
  }
}
