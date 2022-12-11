import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/watertanker/driver/tankerdrivercloud.dart';
import 'package:Homeplex/widgets/loading_widget.dart';
import 'package:Homeplex/widgets/products_showcase_list_view.dart';

import '../../transportation/driver/drivernavbar.dart';

class WatertankerDriverScreen extends StatefulWidget {
  const WatertankerDriverScreen({Key? key}) : super(key: key);
  @override
  State<WatertankerDriverScreen> createState() =>
      _WatertankerDriverScreenState();
}

class _WatertankerDriverScreenState extends State<WatertankerDriverScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount80;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getuserdata();
    getDriverData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  void getDriverData() async {
    List<Widget> temp80 = await Watertankerupload()
        .getProductsByCatogary(firebaseAuth.currentUser!.uid, "yes");
    setState(() {
      discount80 = temp80;
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void getuserdata() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.5,
          backgroundColor: Colors.teal,
          title: Text(
            "   Tanker Driver ${loggedInUser.name}  ",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          // actions: <Widget>[
          //   Stack(
          //     children: <Widget>[
          //       IconButton(
          //         icon:const  Icon(Icons.search),
          //         onPressed: () {
          //           // changeScreen(context, SearchPScreen());
          //         },
          //       ),
          //     ],
          //   ),
          // ],
        ),
        drawer: const DriverNavBar(),
        body: discount80 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        ProductsShowcaseListView(children: discount80!),
                      ],
                    ),
                  ),
                ],
              )
            : const LoadingWidget(),
      )
    ]);
  }
}
