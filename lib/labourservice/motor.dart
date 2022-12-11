import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:Homeplex/locationservice.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:Homeplex/transportation/name.dart';
import 'package:Homeplex/utils/utils.dart';
import '../../widgets/custom_main_button.dart';
import 'cloudlabour.dart';

class Motor extends StatefulWidget {
  const Motor({
    Key? key,
  }) : super(key: key);
  @override
  State<Motor> createState() => _MotorState();
}

class _MotorState extends State<Motor> {
  Expanded spaceThingy = Expanded(child: Container());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isloadinglocation = false;
  String? dropdownError;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController deliverylocationController = TextEditingController();
  TextEditingController nearbyController = TextEditingController();
  TextEditingController customerlocationController = TextEditingController();

  String? finaladdress = ' please click loading location?';
  double? longitude;
  double? latitude;
  NepaliDateTime _selectedDateTime = NepaliDateTime.now();
  final String _design = 'm';
  final DateOrder _dateOrder = DateOrder.mdy;
  String name = 'nnnn';
  String? selectedlabour;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final List<String> _labourtype = <String>[
    'New Installition Motor \n any types of motor pump',
    'Repair & Maintenance',
    'Other'
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

  var selectedTime;

  final List<String> selecttime = <String>[
    'Emergency',
    'Morning',
    'Evening',
  ];
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

  final firestoreInstance = FirebaseFirestore.instance;

  void getuserdata() async {
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
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    getLocation();
    getuserdata();
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
            "Water pump Service",
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

                    const Divider(
                      color: Colors.teal,
                      thickness: 0.4,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "Select Service",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text(
                                  "Please select the service",
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                value: selectedlabour,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedlabour = newValue;
                                    dropdownError = null;
                                  });
                                },
                                items: _labourtype.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const Divider(
                      color: Colors.teal,
                      thickness: 0.4,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "For enquiry,contact",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 20.0),
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
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "Give Date and Time for service",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
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
                                      const EdgeInsets.fromLTRB(10, 1, 10, 1),
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
                          size: 22.0,
                          color: Colors.red,
                        ),
                        // const SizedBox(width: 10.0),
                        DropdownButton(
                          items: selecttime
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color: Color(
                                            0xff0E4d92,
                                          ),
                                          fontSize: 18.0),
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
                            style: TextStyle(color: Colors.red, fontSize: 18.0),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 1, right: 1, top: 15, bottom: 10))
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
                      thickness: 0.3,
                    ),
                    // const SizedBox(width: 20.0),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 5.0),
                          child: Text(
                            "Give your Location",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: TextButton.icon(
                          onPressed: () async {
                            setState(() {
                              isloadinglocation = true;
                            });
                            await getLocation();
                            setState(() {
                              isloadinglocation = false;
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
                          label: const Text('Trace your pickup location')),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 0, bottom: 10),
                      child: !isloadinglocation
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                controller: customerlocationController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                    hoverColor: Colors.black,
                                    filled: true,
                                    labelText: 'Correct your pickup Location',
                                    labelStyle: TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: 15.0),
                                    hintText: "Enter Your Service location",
                                    icon: Icon(
                                      Icons.place,
                                      color: Color(0xff0E4d92),
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'You must enter the Service Location';
                                  }
                                  return null;
                                },
                              ))
                          : const CircularProgressIndicator(),
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.3,
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
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomMainButton(
                        child: const Text("Book Now",
                            style: TextStyle(
                              color: Colors.white,
                            )),
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
                                                          text: selectedlabour
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                        text:
                                                            ' at ${finaladdress.toString()} ',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const TextSpan(
                                                          text:
                                                              "\n Our team will call you soon\n in ",
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
                                                          //  String uid = Utils().getUid();
                                                          String output = await LabourCloudFirestoreClass().uploadOrderLabourToDatabase(
                                                              deliverylocation:
                                                                  customerlocationController
                                                                      .text,
                                                              orderid: '',
                                                              phoneno:
                                                                  phonenoController
                                                                      .text,
                                                              pickupdate:
                                                                  _selectedDateTime
                                                                      .toString(),
                                                              tracelocation:
                                                                  finaladdress
                                                                      .toString(),
                                                              longitude: longitude!
                                                                  .toDouble(),
                                                              latitude: latitude!
                                                                  .toDouble(),
                                                              serviceTime:
                                                                  selectedTime,
                                                              labourType:
                                                                  selectedlabour
                                                                      .toString(),
                                                              uplodername:
                                                                  usernameController
                                                                      .text,
                                                              userName:
                                                                  loggedInUser
                                                                      .name
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
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
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
                          "  Our team will contact soon \n  to Provide the service.",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.cuprum(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 20.0),
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
