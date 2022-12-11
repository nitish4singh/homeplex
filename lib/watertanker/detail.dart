import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/watertanker/tankerdatabase.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:Homeplex/locationservice.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:Homeplex/transportation/name.dart';
import 'package:Homeplex/utils/utils.dart';
import '../../widgets/custom_main_button.dart';
import 'model.dart';

class TankerDetails extends StatefulWidget {
  final TankerModel tankerModel;
  const TankerDetails({
    Key? key,
    required this.tankerModel,
  }) : super(key: key);

  @override
  State<TankerDetails> createState() => _TankerDetailsState();
}

class _TankerDetailsState extends State<TankerDetails> {
  Expanded spaceThingy = Expanded(child: Container());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingforlocation = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController deliverylocationController = TextEditingController();
  TextEditingController nearbyController = TextEditingController();
  TextEditingController customerlocationController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String finaladdress = ' please click loading location?';
  double? longitude;
  double? latitude;
  NepaliDateTime _selectedDateTime = NepaliDateTime.now();
  final String _design = 'm';
  final DateOrder _dateOrder = DateOrder.mdy;
  String post = 'no';
  String labour = '';
  var selectedTime;

  final List<String> _pickuptime = <String>[
    'Morning',
    'Evening',
  ];
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    phonenoController.dispose();
    deliverylocationController.dispose();
    nearbyController.dispose();
    customerlocationController.dispose();
  }

  final firestoreInstance = FirebaseFirestore.instance;

  void getuserdata() async {
    //super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        phonenoController.text = loggedInUser.phone.toString();
        usernameController.text = loggedInUser.name.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
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
            "  ${placeMark!.subLocality}, ${placeMark.subAdministrativeArea}, ${placeMark.street},";
        customerlocationController.text = finaladdress.toString();
      });
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
            "Tanker Detail",
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
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                          widget.tankerModel.url,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
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
                                  "Id :  ${widget.tankerModel.uid}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Tanker Target Area :  ${widget.tankerModel.targetarea}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Driver Name :  ${widget.tankerModel.drivername}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Driver Licience no:  ${widget.tankerModel.licienceno}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "Vehical no :  ${widget.tankerModel.vehicalname}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  "carrying capacity :  ${widget.tankerModel.capacity}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5.0,
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
                    const Divider(),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "For enquiry, contact",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Colors.red, fontSize: 18.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 5.0),
                          child: Card(
                            shadowColor: Colors.grey,
                            margin: const EdgeInsets.all(1),
                            child: TextButton(
                              onPressed: () {
                                customLaunch('tel:+9779862287720');
                              },
                              child: const Icon(
                                Icons.phone_in_talk_rounded,
                                size: 25,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.4,
                      color: Colors.teal,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "Give your location detail",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    // const Divider(),
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
                          label: const Text('click to give your location')),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 0, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: !isLoadingforlocation
                            ? TextFormField(
                                controller: customerlocationController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                    //border: InputBorder.none,
                                    hoverColor: Colors.black,
                                    filled: true,
                                    labelText: 'Correct your pickup Location',
                                    labelStyle: TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: 15.0),
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
                            : const CircularProgressIndicator(),
                      ),
                    ),
                    const Divider(
                      thickness: 0.4,
                      color: Colors.teal,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 10.0),
                      child: Text(
                        "Choose tanker arrival Date & Time ",
                        style: GoogleFonts.changa(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 18.0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 1, 1, 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 1, 20, 1),
                                  child: MaterialButton(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    color: Colors.orange,
                                    onPressed: () async {
                                      if (_design == 'm') {
                                        _selectedDateTime =
                                            (await showMaterialDatePicker(
                                          context: context,
                                          initialDate: _selectedDateTime,
                                          firstDate: NepaliDateTime(2000),
                                          lastDate: NepaliDateTime(2099, 11, 6),
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                        ))!;
                                        setState(() {});
                                      } else {
                                        showCupertinoDatePicker(
                                          context: context,
                                          initialDate: _selectedDateTime,
                                          firstDate: NepaliDateTime(2000),
                                          lastDate: NepaliDateTime(2099, 12),
                                          //language: NepaliUtils().language,
                                          dateOrder: _dateOrder,
                                          onDateChanged: (newDate) {
                                            setState(() {
                                              _selectedDateTime = newDate;
                                            });
                                          },
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "choose date",
                                        style: GoogleFonts.changa(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.lock_clock,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        // const SizedBox(width: 10.0),
                        DropdownButton(
                          items: _pickuptime
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color: Color(
                                            0xff0E4d92,
                                          ),
                                          fontSize: 16.0),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selectedTimeType) {
                            setState(() {
                              selectedTime = selectedTimeType;
                            });
                          },
                          value: selectedTime,
                          isExpanded: false,
                          hint: const Text(
                            'Select time',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 10))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 5, 3),
                      child: Text(
                        '${NepaliDateFormat("EEE, MMMM d, yyyy").format(_selectedDateTime)}',
                        style: GoogleFonts.changa(
                          textStyle: const TextStyle(
                              color: Colors.black, fontSize: 18.0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.4,
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Give your Name',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 18.0),
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
                            controller: usernameController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Your name",
                                icon: Icon(
                                  Icons.person,
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
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Give your Phone number',
                        style: GoogleFonts.baloo2(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 18.0),
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
                            controller: phonenoController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            //minLines: 10,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Your PhoneNumber",
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
                    const Divider(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomMainButton(
                        child: const Text(
                          "Book Now",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        color: Colors.teal,
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
                                                      const TextSpan(
                                                        text:
                                                            'You have selected ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                          text: widget
                                                              .tankerModel
                                                              .vehicalname
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.teal,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const TextSpan(
                                                          text:
                                                              "\n After confirm your Order, Driver  will call you soon\n in ",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          )),
                                                      TextSpan(
                                                          text:
                                                              phonenoController
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
                                                          String output = await TankerCloudFirestoreClass()
                                                              .uploadOrderTankerToDatabase(
                                                                  // id: firebaseAuth.currentUser!.uid,
                                                                  pickuptime: selectedTime
                                                                      .toString(),
                                                                  phoneno: phonenoController
                                                                      .text,
                                                                  vehicalname: widget
                                                                      .tankerModel
                                                                      .vehicalname,
                                                                  tracelocation:
                                                                      finaladdress
                                                                          .toString(),
                                                                  longitude: longitude!
                                                                      .toDouble(),
                                                                  latitude: latitude!
                                                                      .toDouble(),
                                                                  pickupdate: _selectedDateTime
                                                                      .toString(),
                                                                  costumername:
                                                                      usernameController
                                                                          .text,
                                                                  post: post
                                                                      .toString(),
                                                                  driverid: widget
                                                                      .tankerModel
                                                                      .id,
                                                                  licienceno: widget
                                                                      .tankerModel
                                                                      .licienceno,
                                                                  driverphoneno: widget
                                                                      .tankerModel
                                                                      .driverphoneno,
                                                                  drivername: widget
                                                                      .tankerModel
                                                                      .drivername,
                                                                  userName: loggedInUser.name
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
                                                        "Accept",
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
                    const Divider(),
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
                      child: Flexible(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 28, 15),
                        child: Text(
                          " After Your request ,"
                          " our team will contact soon to provide instant service.",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
