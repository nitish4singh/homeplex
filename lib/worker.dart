import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/screens/home_screen.dart';

class Esewapay extends StatefulWidget {
  const Esewapay({Key? key}) : super(key: key);
  @override
  State<Esewapay> createState() => _EsewapayState();
}

class _EsewapayState extends State<Esewapay> {
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController worktypeC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool selection = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('please complete profile firstly')));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          nameC.text = snapshot['name'];
          phoneC.text = snapshot['phone'];
          priceC.text = snapshot['price'];
          worktypeC.text = snapshot['worktype'];
        });
      }
    });
    super.initState();
  }

  bool isSaving = false;
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
          "Pay with Esewa",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
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
                          controller: nameC,
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
                          controller: phoneC,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveInfo() {
    setState(() {
      isSaving = true;
    });
    {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'phone': phoneC.text,
        'price': priceC.text,
        'worktype': worktypeC.text,
      };
      FirebaseFirestore.instance
          .collection('Payment')
          .doc(FirebaseAuth.instance.currentUser!.displayName)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        setState(() {
          isSaving = false;
        });
      });
    }
  }
}
