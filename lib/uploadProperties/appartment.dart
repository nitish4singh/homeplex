import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/uploadProperties/uploadpropertymodel.dart';
import 'package:Homeplex/utils/utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:Homeplex/locationservice.dart';
import '../login/model/user_model.dart';
import '../payment/firstpagepayment.dart';
import '../transportation/name.dart';

class AppartmentUploadScreen extends StatefulWidget {
  const AppartmentUploadScreen({Key? key}) : super(key: key);
  @override
  State<AppartmentUploadScreen> createState() => _AppartmentUploadScreenState();
}

class _AppartmentUploadScreenState extends State<AppartmentUploadScreen> {
  TextEditingController phonenoController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController nearbyController = TextEditingController();
  TextEditingController roomnoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController roomdetailController = TextEditingController();
  TextEditingController actualpriceController = TextEditingController();
  TextEditingController nocarController = TextEditingController();
  TextEditingController nobikeController = TextEditingController();
  TextEditingController propertylocationController = TextEditingController();
  TextEditingController roaddetailController = TextEditingController();
  TextEditingController roompriceController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String family = '';
  String floor = '';
  String parking = "";
  String internet = "";
  String district = "";
  String finaladdress = ' please click loading location?';
  double? longitude;
  double? latitude;
  final String type = "appartment";
  String post = "no";
  int? paidvalue;
  bool isFavourite = false;
  final firestoreInstance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String photoid = '';
  String uid = Utils().getUid();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
    phonenoController.dispose();
    nearbyController.dispose();
    roomdetailController.dispose();
    roomnoController.dispose();
    roompriceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    getLocation();
    getuserdata();
  }

  getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      setState(() {
        latitude = locationData.latitude!;
        longitude = locationData.longitude!;
        finaladdress =
            "${placeMark!.subLocality}, ${placeMark.subAdministrativeArea}, ${placeMark.street},";
        propertylocationController.text = finaladdress.toString();
      });
    }
  }

  void getuserdata() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        photoid = loggedInUser.name.toString();
        phonenoController.text = loggedInUser.phone.toString();
        nameController.text = loggedInUser.name.toString();
      });
    });
  }

  bool isloading = false;
  bool isSale = false;
  bool isLoadingforlocation = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Asset> images = <Asset>[];
  List<String> imageUrls = <String>[];
  String photouid = '';

  save() async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      setState(() {
        isloading = true;
      });
      await uploadImages();
      ProductModel().addProduct(ProductModel(
        imagesUrl: imageUrls,
        uid: uid,
        id: firebaseAuth.currentUser!.uid,
        productName: nameController.text,
        district: district.toString(),
        totalroom: int.parse(roomnoController.text),
        roomdetail: roomdetailController.text,
        rate: int.parse(roompriceController.text),
        famousplacenearby: nearbyController.text,
        formuploadername: nameController.text,
        roaddetail: roaddetailController.text,
        phoneno: phonenoController.text,
        floor: floor.toString(),
        internet: internet.toString(),
        post: post.toString(),
        family: family.toString(),
        totalcarparking: int.parse(nocarController.text),
        totalbikeparking: int.parse(nobikeController.text),
        tracelocation: propertylocationController.text,
        longitude: longitude!.toDouble(),
        latitude: latitude!.toDouble(),
        type: type.toString(),
        sellerName: photoid,
        sellerUid: FirebaseAuth.instance.currentUser!.uid,
      ));
      isloading = false;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentFirstPage(),
          ));
    }
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
          "Upload Appartment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 1.0, 1.0),
                  child: Text(
                    'Select Preference Group',
                    style: GoogleFonts.baloo2(
                      textStyle: const TextStyle(
                          color: Colors.blue,
                          letterSpacing: .5,
                          fontSize: 20.0),
                    ),
                  ),
                ),
                Card(
                    color: Colors.grey[300],
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        child: Wrap(
                          children: <Widget>[
                            ChoiceChip(
                              pressElevation: 0.0,
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.grey[300],
                              label: const Text("Student"),
                              selected: family == 'Student',
                              onSelected: (bool selected) {
                                setState(() {
                                  family = selected ? "Student" : '';
                                });
                                //  print(_value);
                              },
                            ),
                            ChoiceChip(
                              pressElevation: 0.0,
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.grey[300],
                              label: const Text("Family"),
                              selected: family == "Family",
                              onSelected: (bool selected) {
                                setState(() {
                                  family = selected ? "Family" : '';
                                });
                                // print(_value);
                              },
                            ),
                            ChoiceChip(
                              pressElevation: 0.0,
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.grey[300],
                              label: const Text("Individual"),
                              selected: family == "Individual",
                              onSelected: (bool selected) {
                                setState(() {
                                  family = selected ? "Individual" : '';
                                });
                                //
                              },
                            ),
                            ChoiceChip(
                              pressElevation: 0.0,
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.grey[300],
                              label: const Text("Office"),
                              selected: family == "Office",
                              onSelected: (bool selected) {
                                setState(() {
                                  family = selected ? "Office" : '';
                                });
                                // print(_value);
                              },
                            ),
                            ChoiceChip(
                              pressElevation: 0.0,
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.grey[300],
                              label: const Text("Any"),
                              selected: family == "Any",
                              onSelected: (bool selected) {
                                setState(() {
                                  family = selected ? "Any" : "";
                                });
                              },
                            ),
                          ],
                        ))),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 2, 2),
                  child: Text(
                    'Select District:',
                    style: GoogleFonts.baloo2(
                      textStyle:
                          const TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                  ),
                ),
                Card(
                    color: Colors.grey[300],
                    child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: Wrap(spacing: 12.0, children: <Widget>[
                          ChoiceChip(
                            pressElevation: 0.0,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            label: const Text("kathmandu"),
                            selected: district == 'kathmandu',
                            onSelected: (bool selected) {
                              setState(() {
                                district = selected ? "kathmandu" : "";
                              });
                            },
                          ),
                          ChoiceChip(
                            pressElevation: 0.0,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            label: const Text("Bhaktapur"),
                            selected: district == "bhaktapur",
                            onSelected: (bool selected) {
                              setState(() {
                                district = selected ? "bhaktapur" : "";
                              });
                            },
                          ),
                          ChoiceChip(
                            pressElevation: 0.0,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            label: const Text("Lalitpur"),
                            selected: district == "lalitpur",
                            onSelected: (bool selected) {
                              setState(() {
                                district = selected ? "lalitpur" : "";
                              });
                            },
                          ),
                        ]))),
                const Divider(),
                Card(
                    color: Colors.grey[300],
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Wrap(spacing: 12.0, children: <Widget>[
                          Text(
                            'Wifi facility:    ',
                            style: GoogleFonts.baloo2(
                              textStyle: const TextStyle(
                                  color: Colors.blue,
                                  letterSpacing: .5,
                                  fontSize: 20.0),
                            ),
                          ),
                          ChoiceChip(
                            pressElevation: 0.0,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            label: const Text("Avilable"),
                            selected: internet == 'Avilable',
                            onSelected: (bool selected) {
                              setState(() {
                                internet = selected ? "Avilable" : "";
                              });
                            },
                          ),
                          ChoiceChip(
                            pressElevation: 0.0,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey[300],
                            label: const Text("Not Avilable"),
                            selected: internet == "NOt Avilable",
                            onSelected: (bool selected) {
                              setState(() {
                                internet = selected ? "NOt Avilable" : "";
                              });
                            },
                          ),
                        ]))),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 2, 2, 2),
                  child: Text(
                    'Give parking detail',
                    style: GoogleFonts.baloo2(
                      textStyle: const TextStyle(
                          color: Colors.blue,
                          // letterSpacing: .5,
                          fontSize: 20.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 35, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: nobikeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "No of Bike",
                                //  icon: Icon(Icons.support_agent, color: Color(0xff0E4d92),)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Give 0 if their is not parking facilities';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 35, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: nocarController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "No of Car",
                                //  icon: Icon(Icons.support_agent, color: Color(0xff0E4d92),)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Give 0 if their is not parking facilities';
                                }
                                return null;
                              },
                            ),
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
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: TextButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoadingforlocation = true;
                        });
                        await getLocation();
                        setState(() {
                          isLoadingforlocation = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        onSurface: Colors.grey,
                        shadowColor: Colors.red,
                        elevation: 5,
                      ),
                      icon: const Icon(Icons.room_rounded),
                      label: const Text('Trace your Property location')),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 0, bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: !isLoadingforlocation
                        ? TextFormField(
                            controller: propertylocationController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            decoration: const InputDecoration(
                                //border: InputBorder.none,
                                hoverColor: Colors.black,
                                filled: true,
                                labelText: 'Correct your pickup Location',
                                labelStyle: TextStyle(
                                    color: Colors.lightBlue, fontSize: 15.0),
                                hintText: "Enter Your pickup location",
                                icon: Icon(
                                  Icons.place,
                                  color: Color(0xff0E4d92),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'You must enter the pickuplocation';
                              }
                              return null;
                            },
                          )
                        : const SpinKitWave(
                            color: Colors.orange,
                          ),
                  ),
                ),
                const Divider(),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Total no of Rooom ',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .3,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 0, bottom: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: roomnoController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Total no of room",
                                  icon: Icon(
                                    Icons.house,
                                    color: Color(0xff0E4d92),
                                  )),
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
                    ]),
                const Divider(),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Give all Room Detail',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 5, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: roomdetailController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "No of bedroom \n No of toilet \n Other Room Detail Etc",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'must give the Room detail';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Price per month',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 5, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: roompriceController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _calculate();
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Price per month ",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'You must give the Rent price of Room';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Nearby famous place',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 5, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: nearbyController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nearby famous place",
                                  icon: Icon(
                                    Icons.room,
                                    color: Color(0xff0E4d92),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Famous Place';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Give front Road Detail',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 5, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: roaddetailController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Give front Road Detail",
                                  icon: Icon(
                                    Icons.add_road,
                                    color: Color(0xff0E4d92),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'You must give road detail';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Enter your name',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 5, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your name ",
                                  icon: Icon(
                                    Icons.person,
                                    color: Color(0xff0E4d92),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'You must give your name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      Text(
                        'Give your Phone number',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              letterSpacing: .5,
                              fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 90, top: 5, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff0E4d92),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              controller: phonenoController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Give your phone number",
                                  icon: Icon(
                                    Icons.phone,
                                    color: Color(0xff0E4d92),
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'You must give your phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                const Divider(
                  color: Colors.teal,
                  thickness: 0.3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Give up to 5 image',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          letterSpacing: .5,
                          fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  margin: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            loadAsset();
                          },
                          child: const Text('pick images')),
                      Expanded(child: buildGrdiView())
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.teal,
                  thickness: 0.3,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    'Notice',
                    style: GoogleFonts.baloo2(
                      textStyle: const TextStyle(
                          color: Color(0xffb70855), fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Card(
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Dear Costumer you should pay ',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          TextSpan(
                              text:
                                  " Rs.${actualpriceController.text}  through Online payment ",
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(
                            text: ',  before upload your properties ',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ]),
                      ),
                    )),
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
                !isloading
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(45, 15, 45, 5),
                        child: MaterialButton(
                          minWidth: 100.0,
                          height: 35,
                          color: Colors.teal,
                          onPressed: () async {
                            bool isValidate = formKey.currentState!.validate();
                            if (isValidate) {
                              setState(() {
                                isloading = true;
                              });
                              await save();
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Text(
                              'Click to pay & Upload Property',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))
                    : const SpinKitWave(
                        color: Colors.orange,
                      ),
                const Divider(
                  color: Colors.teal,
                  thickness: 0.3,
                ),
              ],
            )),
      ),
    );
  }

  loadAsset() async {
    List<Asset> resultImages = <Asset>[];
    String error = "something went wrong";
    try {
      resultImages = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
      );
      setState(() {
        images = resultImages;
      });
    } catch (e) {
      error = e.toString();
    }
  }

  Future postImages(Asset imagefile) async {
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage db = FirebaseStorage.instance;
    await db.ref().child("property").child(photoid).child(filename).putData(
        (await imagefile.getByteData(quality: 40)).buffer.asUint8List());

    return db
        .ref()
        .child("property")
        .child(photoid)
        .child(filename)
        .getDownloadURL();
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
      }).catchError((e) {});
    }
  }

  void _calculate() {
    if (roompriceController.text.trim().isNotEmpty) {
      final firstValue = int.parse(roompriceController.text);
      paidvalue = ((firstValue * 5) ~/ (100)).toInt();
      setState(() {
        paidvalue;
      });

      final fourthvalue = int.parse(paidvalue.toString());
      actualpriceController.text = (fourthvalue.toString());
    }
  }

  Widget buildGrdiView() {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: images.isEmpty
            ? IconButton(
                onPressed: () {
                  loadAsset();
                },
                icon: const Icon(Icons.add),
              )
            : GridView.count(
                crossAxisCount: 3,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child:
                            AssetThumb(asset: asset, width: 150, height: 150)),
                  );
                }),
              ));
  }
}
