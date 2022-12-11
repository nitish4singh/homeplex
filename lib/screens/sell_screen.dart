import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:Homeplex/screens/secondpageroom.dart';
import 'package:google_fonts/google_fonts.dart';
import '../transportation/name.dart';
import '../widgets/loading_widget.dart';
import 'formfirstpage.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);
  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;

  TextEditingController phonenoController = TextEditingController();


  List<int> keysForDiscount = [0, 70, 60, 50];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Property upload",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Properties1(),
                              Properties2(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 10, 5),
                  child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width - 70,
                      padding: const EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5.5,
                              blurRadius: 5.5,
                            )
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 5.0, 5.0, 5.0),
                                child: Text(
                                  "For any Enquiry contact",
                                  style: GoogleFonts.changa(
                                    textStyle: const TextStyle(
                                        color: Color(0xff0E4d92),
                                        fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 35),
                              child: Card(
                                shadowColor: Colors.grey,
                                margin: const EdgeInsets.all(2),
                                child: TextButton(
                                  onPressed: () {
                                    customLaunch('tel:+9779862287720');
                                  },
                                  child: const Icon(
                                    Icons.phone,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ])),
                ),
                const Divider(),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 1, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'step to upload Property',
                        style: GoogleFonts.changa(
                          textStyle: const TextStyle(
                              color: Color(0xff0E4d92), fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: <Widget>[
                    Flexible(
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "Step 1: Select above property type & click. ",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step2: App will ask location permission  to  trace your property location then allow all permission.",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step4: Fill the information and also  provide maximum image 5 from gallary according to your choice. ",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step4: Recheck  the location,or give more detail location. ",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step5: Recheck the name and phone number.",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step6: Remember the amount that has to be paid for service charge.",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step7: Click on  pay and upload ,after that choose the payment method.",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step8: If you have choosen esewa payment method the enter the amount that has to be paid then give esewa id & password then do login ,give otp then complete your payment process.",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step9: If you have choosen  other banking services then pay on given bank detail  after payment provide screenshot and ask detail in app.",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Step10: After your all process are completed ,our team will verify your details then your property will be visible on app. ",
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Any help required for that contact us ",
                              style:
                                  TextStyle(fontSize: 19, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                // YoutubePlayerBuilder(
                //   player: YoutubePlayer(
                //     controller: youtubePlayerController,
                //   ),
                //   builder: (context, player) {
                //     return Row(
                //       children: [
                //         player,
                //       ],
                //     );
                //   },
                // ),
              ]),
            )
          : const LoadingWidget(),
    );
  }
}
