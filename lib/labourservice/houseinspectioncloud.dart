import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Homeplex/labourservice/houseinspectionorder.dart';
import 'package:Homeplex/labourservice/houseinspectionwidgets.dart';
import 'package:Homeplex/utils/utils.dart';
import 'houseinspectionmodel.dart';

class HouseInspectionCloud {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid11 = Utils().getUid();

  Future<String> uploadOrderinspectionToDatabase({
    required String uplodername,
    required String phoneno,
    required String tracelocation,
    required double longitude,
    required double latitude,
    required String deliverylocation,
    required int servicecharge,
    required String engineername,
    required String serviceTime,
    required String speciality,
    required String pickupdate,
    required String id,
    required String servicetype,
  }) async {
    engineername.trim();

    String output = "Something went wrong";
    if (engineername != "") {
      try {
        String uid = Utils().getUid();
        HouseInspectionOrder product = HouseInspectionOrder(
            tracelocation: tracelocation,
            latitude: latitude,
            longitude: longitude,
            servicetime: serviceTime,
            id: id,
            phone: phoneno,
            servicecharge: servicecharge,
            engineername: engineername,
            uplodername: uplodername,
            pickupdate: pickupdate,
            servicetype: servicetype,
            speciality: speciality);

        await firebaseFirestore
            .collection("houseinspectionorder")
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

  Future<List<Widget>> gethouseinspection() async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap =
        await firebaseFirestore.collection("houseinspection").get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      HomeInspectionModel model = HomeInspectionModel.getModelFromJson(
          json: (docSnap.data() as dynamic));
      children.add(HouseInspectionWidets(homeInspectionModel: model));
    }
    return children;
  }
}
