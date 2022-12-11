import 'package:Homeplex/payment/bankpaymentsuccess.dart';
import 'package:Homeplex/payment/otherbankingpayment.dart';
import 'package:Homeplex/payment/paymentmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:Homeplex/layout/favourate.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/custom_main_button.dart';
import '../transportation/name.dart';

class RentDetail extends StatefulWidget {
  final RentModel rentModel;
  final String? id;
  const RentDetail({
    Key? key,
    this.id,
    required this.rentModel,
  }) : super(key: key);
  @override
  State<RentDetail> createState() => _RentDetailState();
}

class _RentDetailState extends State<RentDetail> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    showfeature();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  bool paymentresult = false;
  String? verifypayment = 'no';
  String payment = 'no';
  void showfeature() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('payment')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    setState(() {
      payment = snap['verifyPayment'];
    });
    if (payment == 'yes') {
      setState(() {
        paymentresult = true;
      });
    } else {
      setState(() {
        paymentresult = false;
      });
    }
  }

  DateTime CurrentDate = DateTime.now();

  saveafterpayment() async {
    EsewaModel().addProduct(EsewaModel(
      verifyPayment: verifypayment,
      amount: 300.toString(),
      name: loggedInUser.name,
      phone: loggedInUser.phone,
      uid: firebaseAuth.currentUser!.uid,
      date: CurrentDate.toString(),
      paymentmode: 'esewa',
    ));
  }

  addToFavrourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({
      "pid": widget.rentModel.uid,
      'name': loggedInUser.name,
      'phone': loggedInUser.phone,
    });
  }

  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  bool isfvrt = false;
  Expanded spaceThingy = Expanded(child: Container());
  @override
  Widget build(BuildContext context) {
    final double lat = widget.rentModel.latitude;
    final double lon = widget.rentModel.longitude;
    final String phoneno = widget.rentModel.phoneno;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.teal,
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Rent Details",
          style: TextStyle(color: Colors.white),
        ),
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
                      widget.rentModel.imagesUrl[selectedIndex],
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        widget.rentModel.imagesUrl.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Image.network(
                                widget.rentModel.imagesUrl[index],
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Card(
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                      child: Text(
                        "PropertyId:${widget.rentModel.uid} ",
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.white,
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
                        "${widget.rentModel.tracelocation} ",
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    )),
                const Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.home,
                              size: 20,
                              color: Colors.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 5.0, 5.0, 5.0),
                              child: Text(
                                "Total Room",
                                style: GoogleFonts.baloo2(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${widget.rentModel.totalroom} ",
                                  style: GoogleFonts.baloo2(
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
                              size: 20,
                              color: Colors.blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 5.0, 5.0, 5.0),
                              child: Text(
                                "wifi-facility",
                                style: GoogleFonts.baloo2(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${widget.rentModel.internet} ",
                                  style: GoogleFonts.baloo2(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Card(
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                const Icon(
                                  Icons.local_taxi,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${widget.rentModel.totalcarparking} ",
                                      style: GoogleFonts.baloo2(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                const Icon(
                                  Icons.motorcycle_outlined,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${widget.rentModel.totalbikeparking} ",
                                      style: GoogleFonts.baloo2(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ]),
                const Divider(),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(21.0, 5.0, 5.0, 5.0),
                      child: Text(
                        "RentPrice:",
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 1.0, 1.0, 1.0),
                        child: Text(
                          "Rs.${widget.rentModel.rate.toInt()} /Month",
                          style: GoogleFonts.baloo2(
                            textStyle: const TextStyle(
                                color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Card(
                        color: Colors.grey[200],
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Houseowener Name:  ${widget.rentModel.formuploadername}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              color: Colors.teal,
                              thickness: 0.3,
                            ),
                            Text(
                              "Preference group:  ${widget.rentModel.family}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Divider(
                              color: Colors.teal,
                              thickness: 0.3,
                            ),
                            Text(
                              "TraceLocation : ${widget.rentModel.tracelocation}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Divider(
                              color: Colors.teal,
                              thickness: 0.3,
                            ),
                            Text(
                              "Famous Place NearBy: ${widget.rentModel.famousplacenearby}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Divider(
                              color: Colors.teal,
                              thickness: 0.3,
                            ),
                            Text(
                              "RoomDetail :\n  ${widget.rentModel.roomdetail}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const Divider(
                              color: Colors.teal,
                              thickness: 0.2,
                            ),
                            Text(
                              "Road Information :  ${widget.rentModel.roaddetail}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.teal,
                  thickness: 0.3,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                          child: Text(
                            "For your support/Help no:",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 35),
                        child: Card(
                          shadowColor: Colors.grey,
                          margin: const EdgeInsets.all(2),
                          child: TextButton(
                            onPressed: () {
                              customLaunch('tel:+9779862287720');
                            },
                            child: const Icon(
                              Icons.phone,
                              size: 30,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ]),
                const Divider(
                  color: Colors.teal,
                  thickness: 0.3,
                ),
                paymentresult
                    ? Row(
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
                                style: GoogleFonts.baloo2(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ), // <-- Text
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton.icon(
                              onPressed: () => MapsLauncher.launchCoordinates(
                                  lat,
                                  lon,
                                  'Click on start to navigate on properties '),
                              icon: const Icon(
                                Icons.navigation,
                                size: 45.0,
                              ),
                              label: Text(
                                'Navigate to \n  properties',
                                style: GoogleFonts.baloo2(
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ), // <-- Text
                            ),
                          ])
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
                        child: Row(
                          children: [
                            Flexible(
                              child: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                    text: 'Please pay first ',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  TextSpan(
                                      text: ' Rs.300 Service charge ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text:
                                        ' to get location/navigator and owner contact, If you paid once, you can use the service upto one month',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                !paymentresult
                    ? Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 15, 30, 15),
                                  primary: Colors.white,
                                  backgroundColor: Colors.teal,
                                  onSurface: Colors.grey,
                                ),
                                child: const Text(
                                  ' Pay through  Esewa',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  saveafterpayment();
                                  try {
                                    EsewaFlutterSdk.initPayment(
                                      esewaConfig: EsewaConfig(
                                        environment: Environment.live,
                                        clientId:
                                            "LRwIEhEfDh1ZNQURWUE/HwFXXx0QGw0=",
                                        secretId: "WBYWEhYSRQ0WCBYVGwQL",
                                      ),
                                      esewaPayment: EsewaPayment(
                                        productId: widget.rentModel.uid,
                                        productName:
                                            widget.rentModel.productName,
                                        productPrice: '300',
                                        callbackUrl: "www.test-url.com",
                                      ),
                                      onPaymentSuccess:
                                          (EsewaPaymentSuccessResult data) {
                                        debugPrint(":::SUCCESS::: => $data");
                                        setState(() {
                                          verifypayment = 'yes';
                                        });
                                        saveafterpayment();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BankPaymentSuccessScreen(),
                                            ));
                                      },
                                      onPaymentFailure: (data) {
                                        debugPrint(":::FAILURE::: => $data");
                                      },
                                      onPaymentCancellation: (data) {
                                        debugPrint(
                                            ":::CANCELLATION::: => $data");
                                        Navigator.pop(context);
                                      },
                                    );
                                  } on Exception catch (e) {
                                    debugPrint("EXCEPTION : ${e.toString()}");
                                  }
                                },
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 15, 30, 15),
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                            child: const Text(
                              'Other Banking',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OtherBanking(),
                                  ));
                            },
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 5.0,
                      ),
                const Divider(color: Colors.teal, thickness: 0.2),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('favourite')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('items')
                        .where('pid', isEqualTo: widget.rentModel.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return const Text("");
                      }
                      return CustomMainButton(
                          child: snapshot.data!.docs.isEmpty
                              ? const Text(
                                  "Take a Intrest",
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  "Cancle Intrest",
                                  style: TextStyle(color: Colors.white),
                                ),
                          color: snapshot.data!.docs.isEmpty
                              ? Colors.teal
                              : const Color(0xff9b0b79),
                          isLoading: false,
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                          padding: const EdgeInsets.all(1.0),
                                          height: 250,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(children: [
                                                        const TextSpan(
                                                          text:
                                                              'You have selected ',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        TextSpan(
                                                            text:
                                                                'Room Id${widget.rentModel.uid}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                          text:
                                                              ' Having Rent ${widget.rentModel.rate} per Month',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        const TextSpan(
                                                            text:
                                                                "\n Re-visit ,you can go to your intrest screen ,our team will contact you soon on",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17,
                                                            )),
                                                        TextSpan(
                                                            text: widget
                                                                .rentModel
                                                                .phoneno,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                    ),
                                                    SizedBox(
                                                        width: 320.0,
                                                        child: ElevatedButton(
                                                          child:
                                                              snapshot
                                                                      .data!
                                                                      .docs
                                                                      .isEmpty
                                                                  ? const Text(
                                                                      "Take a Intrest",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : const Text(
                                                                      "Cancle Intrest",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                          onPressed: () async {
                                                            snapshot.data!.docs
                                                                    .isEmpty
                                                                ? addToFavrourite()
                                                                : removeToFavrourite(
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .first
                                                                        .id);
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const FavorateScreen()));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        22,
                                                                    vertical:
                                                                        12),
                                                            primary: snapshot
                                                                    .data!
                                                                    .docs
                                                                    .isEmpty
                                                                ? const Color(
                                                                    0xff4adede)
                                                                : Colors.red,
                                                            onPrimary:
                                                                Colors.white,
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 320.0,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const FavorateScreen()));
                                                        },
                                                        child: const Text(
                                                          "Go to  Intrest ",
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                            primary:
                                                                Colors.grey,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        50,
                                                                    vertical:
                                                                        10),
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ),
                                                    ),
                                                  ]))));
                                });
                          });
                    }),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
