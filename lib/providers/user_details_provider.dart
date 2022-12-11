import 'package:flutter/material.dart';
import 'package:Homeplex/model/user_details_model.dart';
import 'package:Homeplex/resources/cloudfirestore_methods.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
            name: "please login",
            address: "",
            phone: "loading",
            email: "loading",
            id: "loadding",
            profilePic: '');
  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
