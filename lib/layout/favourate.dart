import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:Homeplex/sellerCostumer/costumerIntrestShow.dart';
import '../widgets/products_showcase_list_view.dart';

class FavorateScreen extends StatefulWidget {
  const FavorateScreen({Key? key}) : super(key: key);
  @override
  State<FavorateScreen> createState() => _FavorateScreenState();
}

class _FavorateScreenState extends State<FavorateScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  List ids = [];
  getId() async {
    FirebaseFirestore.instance
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          ids.add(element['pid']);
        });
      });
    });
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0.5,
            backgroundColor: Colors.teal,
            title: const Text(
              "  Your intrest",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                }),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 5.0, 1.0),
                          child: Text(
                            "Follow Your instrest",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('rentProperty')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.data!.docs
                              .where((element) => ids.contains(element["uid"]))
                              .isEmpty) {
                            return const Center(
                                child: Text(
                              "No Intrest Items Found \n Item may be Booked by other person",
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ));
                          } else {
                            List<QueryDocumentSnapshot<Object?>> fp = snapshot
                                .data!.docs
                                .where(
                                    (element) => ids.contains(element["uid"]))
                                .toList();
                            List<Widget> children = [];
                            for (int i = 0; i < fp.length; i++) {
                              RentModel model = RentModel.getModelFromJson(
                                  json: snapshot.data!.docs[i].data());
                              children.add(CostumerIntrestProductWidget(
                                  rentProductModel: model));
                            }
                            return ProductsShowcaseListView(children: children);
                          }
                        }),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                  ],
                ),
              ),
              // UserDetailsBar(
              //   offset: offset,
              // ),
            ],
          ))
    ]);
  }
}
