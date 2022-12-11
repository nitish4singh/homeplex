import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductModel {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //String uid = Utils().getUid();

  List<String>? imagesUrl;
  String? productName;
  String? uid;
  String? sellerName;
  String? sellerUid;
  String? floor;
  int? totalroom;
  String? roomdetail;
  int? rate;
  String? famousplacenearby;
  String? formuploadername;
  String? phoneno;
  String? roaddetail;
  String? internet;
  String? family;
  String? tracelocation;
  double? latitude;
  double? longitude;
  String? district;
  String? type;
  String? post;
  String? id;
  int? totalcarparking;
  int? totalbikeparking;

  ProductModel({
    this.imagesUrl,
    this.productName,
    this.uid,
    this.sellerName,
    this.sellerUid,
    this.floor,
    this.totalroom,
    this.roomdetail,
    this.rate,
    this.famousplacenearby,
    this.formuploadername,
    this.phoneno,
    this.roaddetail,
    this.internet,
    this.family,
    this.tracelocation,
    this.latitude,
    this.longitude,
    this.district,
    this.type,
    this.post,
    this.id,
    this.totalcarparking,
    this.totalbikeparking,
  });

  Future<void> addProduct(ProductModel productModel) async {
    Map<String, dynamic> data = {
      "productName": productModel.productName,
      "imagesUrl": productModel.imagesUrl,
      "uid": productModel.uid,
      'sellerName': productModel.sellerName,
      'sellerUid': productModel.sellerUid,
      'totalroom': productModel.totalroom,
      'roomdetail': productModel.roomdetail,
      'rate': productModel.rate,
      'famousplacenearby': productModel.famousplacenearby,
      'formuploadername': productModel.formuploadername,
      'phoneno': productModel.phoneno,
      'floor': productModel.floor,
      'roaddetail': productModel.roaddetail,
      'internet': productModel.internet,
      'family': productModel.family,
      'tracelocation': productModel.tracelocation,
      'longitude': productModel.longitude,
      'latitude': productModel.latitude,
      'district': productModel.district,
      'type': productModel.type,
      'post': productModel.post,
      'id': productModel.id,
      'totalcarparking': productModel.totalcarparking,
      'totalbikeparking': productModel.totalbikeparking,
    };

    await firebaseFirestore
        .collection("rentProperty")
        .doc(firebaseAuth.currentUser!.uid)
        .set(data);
  }
}
