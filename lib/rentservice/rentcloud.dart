import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:Homeplex/model/order_request_model.dart';
import 'package:Homeplex/model/user_details_model.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/rentservice/rentwidets.dart';
import 'package:Homeplex/utils/utils.dart';

class RentCloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid11 = Utils().getUid();

  Future<List<Widget>> getProductsByCatogary(
      String district, String type, String post) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("rentProperty")
        .where("district", isEqualTo: district)
        .where("type", isEqualTo: type)
        .where("post", isEqualTo: post)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      RentModel model =
          RentModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(RentProductWidgets(rentProductModel: model));
    }
    return children;
  }

  Future<List<Widget>> getProductsByAllCatogary(
      String district, String post) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("rentProperty")
        .where("district", isEqualTo: district)
        .where("post", isEqualTo: post)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      RentModel model =
          RentModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(RentProductWidgets(rentProductModel: model));
    }
    return children;
  }

  Future<List<Widget>> getProductsByOffice(
      String district, String family, String post) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("rentProperty")
        .where("district", isEqualTo: district)
        .where("family", isEqualTo: family)
        .where("post", isEqualTo: post)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      RentModel model =
          RentModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(RentProductWidgets(rentProductModel: model));
    }
    return children;
  }

  Future addProductToCart({required RentModel rentModel}) async {
    await firebaseFirestore
        .collection("intrest")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(rentModel.uid)
        .set(rentModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      RentModel model =
          RentModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required RentModel model, required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required RentModel model, required UserDetailsModel userDetails}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: model.productName, buyersAddress: userDetails.address);
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }
}
