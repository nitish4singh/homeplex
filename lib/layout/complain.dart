import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/screens/home_screen.dart';
import '../transportation/name.dart';
import '../utils/utils.dart';

class ComplainService extends StatefulWidget {
  const ComplainService({Key? key}) : super(key: key);

  @override
  _ComplainServiceState createState() => _ComplainServiceState();
}

class _ComplainServiceState extends State<ComplainService> {
  ComplainServicedb complainService = ComplainServicedb();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController complainController = TextEditingController();

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.teal),
        ),
        elevation: 0.0,
        title: Text(
          'Your Complain',
          style: GoogleFonts.changa(
            textStyle: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 1,
                    ),
                    const Divider(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Flexible(
                        // padding: const EdgeInsets.fromLTRB(30, 10, 30, 15),
                        child: Text(
                          "Dear costumer,we are here to listen  your Complain or any suggestion or any problem ",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.baloo2(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 5),
                      child: Container(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width - 70,
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 35),
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
                    // const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: nameController,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color(0xffc8003c),
                            ),
                            hintText: 'Your full Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must enter the name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: phoneController,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.phone,
                              color: Color(0xffc8003c),
                            ),
                            hintText: 'Give your Phone Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Give your Phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: complainController,
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Please give your complain  ',
                          hintText: 'Give your complain or suggestions ',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must enter the Features for GRILL/WINDOW ';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        // padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                        onPressed: () {
                          validateAndUpload();
                        },
                        child: Text(
                          "Submit Now",
                          style: GoogleFonts.changa(
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 19.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      complainService.uploadComplain(
        name: nameController.text,
        phone: phoneController.text,
        complain: complainController.text,
      );
      setState(() => isLoading = false);

      Utils().showSnackBar(
          context: context,
          content: "Your request has \n been successful uploded ");
      //  changeScreen(context, ThankuComplainScreen());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
  }
}

class ComplainServicedb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'ComplainBox';
  void uploadComplain({
    String? name,
    String? complain,
    String? phone,
    String? productId,
  }) {
    String uid = Utils().getUid();
    String productId = uid;
    _firestore.collection(ref).doc(productId).set({
      'name': name,
      'complain': complain,
      'phone': phone,
      'complainId': productId,
    });
  }
}
