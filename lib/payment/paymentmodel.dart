import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EsewaModel {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String? verifyPayment;
  String? name;
  String? uid;
  String? phone;
  String? amount;
  String? date;
  String? paymentmode;

  EsewaModel({
    this.name,
    this.uid,
    this.phone,
    this.amount,
    this.verifyPayment,
    this.date,
    this.paymentmode,
  });

  Future<void> addProduct(EsewaModel esewaModel) async {
    Map<String, dynamic> data = {
      "name": esewaModel.name,
      "uid": esewaModel.uid,
      'phone': esewaModel.phone,
      'amount': esewaModel.amount,
      "verifyPayment": esewaModel.verifyPayment,
      "date": esewaModel.date,
      "paymentmode": esewaModel.paymentmode,
    };

    await firebaseFirestore
        .collection("payment")
        .doc(firebaseAuth.currentUser!.uid)
        .set(data);
        
  }
}
