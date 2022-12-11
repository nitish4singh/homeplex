import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:Homeplex/transportation/name.dart';
import 'package:Homeplex/utils/utils.dart';
import 'package:Homeplex/watertanker/driver/tankerdrivercloud.dart';
import '../../widgets/custom_main_button.dart';

class WaterTankerUploadScreen extends StatefulWidget {
  // final TransportModel transportModel;
  const WaterTankerUploadScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<WaterTankerUploadScreen> createState() =>
      _WaterTankerUploadScreenState();
}

class _WaterTankerUploadScreenState extends State<WaterTankerUploadScreen> {
  Expanded spaceThingy = Expanded(child: Container());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController drivernameController = TextEditingController();
  TextEditingController drivernoController = TextEditingController();
  TextEditingController kmpriceController = TextEditingController();
  TextEditingController vehicalnameController = TextEditingController();
  TextEditingController liciencenoController = TextEditingController();
  Uint8List? image;
  String? selectedareaType;
  String? selectedtank;
  String post = 'no';
  String labour = '';
  final List<String> _district = <String>[
    'kathmandu',
    'bhaktapur',
    'lalipur',
    'any',
  ];
  final List<String> tankCapacity = <String>[
    '5 thousand liter',
    '7 thousand liter',
    '10 thousand liter',
    '12 thousand liter',
  ];
  @override
  void dispose() {
    super.dispose();
    drivernameController.dispose();
    drivernoController.dispose();
    kmpriceController.dispose();
    vehicalnameController.dispose();
    liciencenoController.dispose();
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
            "Upload WaterTanker",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "Contact for Enquire ?",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(50.0, 0.0, 5.0, 5.0),
                          child: Card(
                            shadowColor: Colors.grey,
                            margin: const EdgeInsets.all(1),
                            child: TextButton(
                              onPressed: () {
                                customLaunch('tel:+9779862287720');
                              },
                              child: const Icon(
                                Icons.phone_in_talk_rounded,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 50.0),
                        const Icon(
                          Icons.place,
                          size: 35.0,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 20.0),
                        DropdownButton(
                          items: _district
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: GoogleFonts.changa(
                                        textStyle: const TextStyle(
                                            color: Color(0xff0E4d92),
                                            fontSize: 23.0),
                                      ),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selectareaType) {
                            setState(() {
                              selectedareaType = selectareaType.toString();
                            });
                          },
                          value: selectedareaType,
                          isExpanded: false,
                          hint: const Text(
                            'Select your area',
                            style: TextStyle(
                                color: Color(0xff0E4d92), fontSize: 21.0),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 2, right: 20, top: 15, bottom: 10))
                      ],
                    ),
                    const Divider(
                      thickness: 0.4,
                      color: Colors.teal,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 30.0),
                        const Icon(
                          Icons.fire_truck,
                          size: 35.0,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 20.0),
                        DropdownButton(
                          items: tankCapacity
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: GoogleFonts.changa(
                                        textStyle: const TextStyle(
                                            color: Color(0xff0E4d92),
                                            fontSize: 23.0),
                                      ),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selecttank) {
                            setState(() {
                              selectedtank = selecttank.toString();
                            });
                          },
                          value: selectedtank,
                          isExpanded: false,
                          hint: const Text(
                            'Select your tank capacity',
                            style: TextStyle(
                                color: Color(0xff0E4d92), fontSize: 21.0),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 2, right: 10, top: 15, bottom: 10))
                      ],
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0E4d92),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: drivernameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter the driver name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'You must enter the name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0E4d92),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: drivernoController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            //minLines: 10,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Driver  PhoneNumber",
                                icon: Icon(
                                  Icons.phone_android,
                                  color: Color(0xff0E4d92),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return value.length >= 10
                                    ? ' please enter the  correct phone number'
                                    : null;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0E4d92),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: kmpriceController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Price for tank ",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter price per tank';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0E4d92),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: vehicalnameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "enter vehical number",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter vehical number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff0E4d92),
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: liciencenoController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Driver licience no",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter Driver   licience no';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 5, 5),
                      child: TextButton.icon(
                          onPressed: () async {
                            Uint8List? temp = await Utils().pickImage1();
                            if (temp != null) {
                              setState(() {
                                image = temp;
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            onSurface: Colors.grey,
                            shadowColor: Colors.red,
                            elevation: 5,
                          ),
                          icon: const Icon(Icons.photo_camera),
                          label:
                              const Text('Insert Vehical Image from Gallery')),
                    ),
                    image != null
                        ? Image.memory(image!)
                        : Text(
                            "      please Provide the room photo ",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Colors.blue,
                                  // letterSpacing: .5,
                                  fontSize: 16.0),
                            ),
                          ),
                    const Divider(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomMainButton(
                        child: const Text(
                          "  Post  ",
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        color: const Color(0xff4adede),
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
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                        text:
                                                            'Dear ${drivernameController.text} you want to join with us ',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const TextSpan(
                                                        text:
                                                            ' by doing aggrement sign  ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const TextSpan(
                                                          text:
                                                              "Between Driver & company ",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      TextSpan(
                                                          text:
                                                              drivernoController
                                                                  .text,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    width: 320.0,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          setState(() =>
                                                              isLoading = true);
                                                          String output = await Watertankerupload()
                                                              .uploadtankerToDatabase(
                                                                  capacity:
                                                                      selectedtank
                                                                          .toString(),
                                                                  kmprice:
                                                                      int.parse(
                                                                    kmpriceController
                                                                        .text,
                                                                  ),
                                                                  driverphoneno:
                                                                      drivernoController
                                                                          .text,
                                                                  image: image,
                                                                  post: post
                                                                      .toString(),
                                                                  vehicalname:
                                                                      vehicalnameController
                                                                          .text,
                                                                  drivername:
                                                                      drivernameController
                                                                          .text,
                                                                  licienceno:
                                                                      liciencenoController
                                                                          .text,
                                                                  targetarea:
                                                                      selectedareaType
                                                                          .toString(),
                                                                  id: FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid);
                                                          if (output ==
                                                              "success") {
                                                            Utils().showSnackBar(
                                                                context:
                                                                    context,
                                                                content:
                                                                    "Your request has \n been successful uploded ");
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const HomeScreen()));
                                                          } else {
                                                            Utils()
                                                                .showSnackBar(
                                                                    context:
                                                                        context,
                                                                    content:
                                                                        output);
                                                            setState(() =>
                                                                isLoading =
                                                                    false);
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please Try Later');
                                                          }
                                                        }
                                                      },
                                                      child: const Text(
                                                        "Conform",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.teal,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      50,
                                                                  vertical: 12),
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 320.0,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Reject",
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                          primary: Colors.grey,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      50,
                                                                  vertical: 10),
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                    ),
                                                  ),
                                                ]))));
                              });
                        }),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 1.0, 5.0, 5.0),
                          child: Text(
                            "Notice",
                            style: GoogleFonts.cuprum(
                              textStyle: const TextStyle(
                                  color: Color(0xffb70855), fontSize: 25.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 28, 15),
                        child: Text(
                          "  After Your request \n"
                          "  Our team will contact soon \n  to verify your request.",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.cuprum(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
