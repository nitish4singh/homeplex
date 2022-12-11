import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/sellerCostumer/costumerIntrestShow.dart';
import 'package:Homeplex/utils/utils.dart';

class CloudFirestoreCostumerClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid11 = Utils().getUid();

  Future addProductToIntrest({required RentModel rentModel}) async {
    await firebaseFirestore
        .collection("rentProperty")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("intrest")
        .doc(rentModel.uid)
        .set(rentModel.getJson());
  }

  Future deleteProductFromIntrest({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .delete();
  }

  Future<List<Widget>> getProductsofCostumer(
    String id,
  ) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("intrest")
        .where("id", isEqualTo: id)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      RentModel model =
          RentModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(CostumerIntrestProductWidget(rentProductModel: model));
    }
    return children;
  }

  Future deleteProductofCostumer({required String id}) async {
    await firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }
}
