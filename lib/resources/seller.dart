import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/sellerCostumer/sellershowwidgets.dart';
import 'package:Homeplex/utils/utils.dart';

class CloudFirestoreSellerClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid = Utils().getUid();

  Future<List<Widget>> getProductsofseller(
    String id,
  ) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("rentProperty")
        .where("id", isEqualTo: id)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];

      RentModel model =
          RentModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SellerProductWidget(rentProductModel: model));
    }

    return children;
  }

  Future deleteProductofSeller({required String id}) async {
    await firebaseFirestore.collection("rentProperty").doc(id).delete();
  }
}
