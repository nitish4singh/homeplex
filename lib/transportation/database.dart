import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:Homeplex/model/order_request_model.dart';
import 'package:Homeplex/model/user_details_model.dart';
import 'package:Homeplex/transportation/model.dart';
import 'package:Homeplex/transportation/ordertransport.dart';
import 'package:Homeplex/transportation/widgets.dart';
import 'package:Homeplex/utils/utils.dart';

import 'costumerOrderwidgets.dart';

class TransportCloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid11 = Utils().getUid();

  Future<String> uploadOrderTransportToDatabase({
    // required Uint8List? image,
    // required int rate,
    // required String famousplacenearby,
    required String userName,
    required String phoneno,
    required String tracelocation,
    required double longitude,
    required double latitude,
    required String deliverylocation,
    required String id,
    required String vehicalname,
    required String pickupdate,
    required String labourneed,
    required String driverid,
    required String post,
    required String pickuptime,
    required String costumername,
    required String drivername,
    required String driverphoneno,
    required String licienceno,
    required String labourcharge,
  }) async {
    vehicalname.trim();

    String output = "Something went wrong";
    if (vehicalname != "") {
      try {
        String uid = Utils().getUid();
        TransportOrder product = TransportOrder(
          tracelocation: tracelocation,
          latitude: latitude,
          longitude: longitude,
          pickuptime: pickuptime,
          deliverylocation: deliverylocation,
          id: id,
          phone: phoneno,
          userName: userName,
          vehicalname: vehicalname,
          labourneed: labourneed,
          labourcharge: labourcharge,
          pickupdate: pickupdate,
          driverid: driverid,
          post: post,
          orderid: uid,
          costumername: costumername,
          drivername: drivername,
          driverphoneno: driverphoneno,
          licienceno: licienceno,
        );

        await firebaseFirestore
            .collection("transportOrder")
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
        FirebaseStorage.instance.ref().child("furniture").child(uid).child('a');
    UploadTask uploadToask = storageRef.putData(image);
    TaskSnapshot task1 = await uploadToask;
    return task1.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsOfTransport(String post) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("vehical")
        .where("post", isEqualTo: post)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      TransportModel model =
          TransportModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(TransportWidets(transportModel: model));
    }
    return children;
  }

  Future<List<Widget>> getProductsOfCostumer(
    String id,
  ) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("transportOrder")
        .where("id", isEqualTo: id)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      TransportOrder model =
          TransportOrder.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(CostumerOrderWidets(transportOrder: model));
    }
    return children;
  }

  Future addProductToCart({required TransportModel productModel}) async {
    await firebaseFirestore
        .collection("intrest")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
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
      TransportModel model =
          TransportModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders(
      {required TransportModel model,
      required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required TransportModel model,
      required UserDetailsModel userDetails}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: model.vehicalname, buyersAddress: userDetails.address);
    await firebaseFirestore
        .collection("users")
        .doc(model.uid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }
}
