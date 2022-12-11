import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Homeplex/labourservice/orderlabourwidgets.dart';
import 'package:Homeplex/labourservice/uploadlabour.dart';
import 'package:Homeplex/utils/utils.dart';

class LabourCloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid11 = Utils().getUid();

  Future<String> uploadOrderLabourToDatabase({
    required String userName,
    required String phoneno,
    required String tracelocation,
    required double longitude,
    required double latitude,
    required String deliverylocation,
    required String id,
    required String labourType,
    required String serviceTime,
    required String uplodername,
    required String pickupdate,
    required String orderid,
    //  required String capacity,
  }) async {
    labourType.trim();

    String output = "Something went wrong";
    if (labourType != "") {
      try {
        String uid = Utils().getUid();
        LabourOrder product = LabourOrder(
            tracelocation: tracelocation,
            latitude: latitude,
            longitude: longitude,
            servicetime: serviceTime,
            id: id,
            phone: phoneno,
            userName: userName,
            labourtype: labourType,
            uplodername: uplodername,
            pickupdate: pickupdate,
            orderid: uid);

        await firebaseFirestore
            .collection("labourservice")
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

  Future<List<Widget>> getProductsOfLabour(String id) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("labourservice")
        .where("id", isEqualTo: id)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      LabourOrder model =
          LabourOrder.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(CostumerlabourOrderWidets(labourOrder: model));
    }
    return children;
  }
}
