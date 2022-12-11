import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/product_model.dart';
import '../providers/user_details_provider.dart';
import '../resources/cloudfirestore_methods.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceThingy = Expanded(child: Container());

  addToFavrourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({"pid": widget.productModel.uid});
  }

  removeToFavrourite(String uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(uid)
        .delete();
  }

  bool isfvrt = false;
  @override
  Widget build(BuildContext context) {
    final String phoneno = widget.productModel.phoneno;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: const Color(0xff4adede),
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // changeScreen(context, Feed());
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              //  changeScreen(context, CartScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    color: Colors.grey[100],
                    height: 300,
                    child: Image.network(
                      widget.productModel.url,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Divider(),
                Card(
                    color: const Color(0xff4adede),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text(
                        "PropertyId:${widget.productModel.uid} ",
                        style: GoogleFonts.changa(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 18.0),
                        ),
                      ),
                    )),

                Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text(
                        "${widget.productModel.tracelocation} ",
                        style: GoogleFonts.changa(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    )),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.home,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 5.0, 5.0, 5.0),
                          child: Text(
                            "Total Room:",
                            style: GoogleFonts.coda(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.productModel.totalroom} ",
                              style: GoogleFonts.cuprum(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.wifi,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                          child: Text(
                            "wifi-facility",
                            style: GoogleFonts.coda(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.productModel.internet} ",
                              style: GoogleFonts.cuprum(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.local_parking,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 5.0, 20.0, 5.0),
                          child: Text(
                            "Parking",
                            style: GoogleFonts.coda(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 15.0),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.productModel.totalbikeparking} ",
                              style: GoogleFonts.cuprum(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ),
                            )),
                      ],
                    ),
                  ),
                ]),
                const Divider(),

                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(21.0, 5.0, 5.0, 5.0),
                      child: Text(
                        "RentPrice:",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
                      child: Text(
                        "Rs.${widget.productModel.rate.toInt()} ",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(21.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "SellerName:",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
                      child: Text(
                        "${widget.productModel.formuploadername} ",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(21.0, 5.0, 1.0, 1.0),
                      child: Text(
                        "Preferred:",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
                      child: Text(
                        "${widget.productModel.family} ",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 50.0, 5.0),
                      child: Text(
                        "Nearby place:\n ${widget.productModel.famousplacenearby} ",
                        style: GoogleFonts.coda(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    )),
                const Divider(),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                        onPressed: () async {
                          final String url1 = 'tel:+$phoneno';
                          if (await canLaunch(url1)) {
                            await launch(url1);
                          }
                        },

                        icon: const Icon(
                          Icons.call,
                          size: 47.0,
                          color: Colors.green,
                        ),
                        label: Text(
                          'Call to \n owener',
                          style: GoogleFonts.coda(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                          ),
                        ), // <-- Text
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.navigation,
                          size: 45.0,
                        ),
                        label: Text(
                          'Navigate to \n  properties',
                          style: GoogleFonts.coda(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                          ),
                        ), // <-- Text
                      ),
                    ]),
                //spaceThingy,
                const SizedBox(
                  height: 20.0,
                ),
                CustomMainButton(
                    child: const Text(
                      "Take a instrest",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: const Color(0xff4adede),
                    isLoading: false,
                    onPressed: () async {
                      //   await CloudFirestoreCostumerClass().addProductToIntrest(
                      //       productModel: widget.productModel);
                      //   Utils().showSnackBar(
                      //       context: context, content: "Added to cart.");
                    }),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('favourite')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('items')
                        .where('pid', isEqualTo: widget.productModel.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return const Text("");
                      }
                      return IconButton(
                          onPressed: () {
                            snapshot.data!.docs.isNotEmpty
                                ? addToFavrourite()
                                : removeToFavrourite(
                                    snapshot.data!.docs.first.id);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: snapshot.data!.docs.isNotEmpty
                                ? Colors.black
                                : Colors.red,
                          ));
                    }),

                const SizedBox(
                  height: 10.0,
                ),
                CustomMainButton(
                    child:const  Text(
                      "Book Now",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () async {
                      await CloudFirestoreClass().addProductToOrders(
                          model: widget.productModel,
                          userDetails: Provider.of<UserDetailsProvider>(context,
                                  listen: false)
                              .userDetails);
                      Utils().showSnackBar(context: context, content: "Done");
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                color: Colors.grey[100],
                height: 300,
                child: Image.network(
                  widget.productModel.url2,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                color: Colors.grey[100],
                height: 300,
                child: Image.network(
                  widget.productModel.url3,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 300,
                color: Colors.grey[100],
                child: Image.network(
                  widget.productModel.url4,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
