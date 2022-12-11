import 'package:Homeplex/payment/bankpaymentsuccess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/payment/paymentmodel.dart';
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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? verifypayment = 'no';
  DateTime CurrentDate = DateTime.now();

  saveafterpayment() async {
    bool isValidate = formKey.currentState!.validate();
    if (isValidate) {
      setState(() {
        selection = true;
      });

      EsewaModel().addProduct(EsewaModel(
        name: nameC.text,
        phone: phoneC.text,
        amount: priceC.text,
        uid: firebaseAuth.currentUser!.uid,
        verifyPayment: verifypayment,
        date: CurrentDate.toString(),
        paymentmode: 'esewa',
      ));
      selection = false;

      
    }
  }

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
          " Esewa Payment",
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
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Enter the amount',
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
                          controller: priceC,
                          keyboardType: TextInputType.number,
                          // maxLength: 10,
                          //minLines: 10,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter the amount",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return value.length <= 5
                                  ? ' please enter the  correct amount'
                                  : null;
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
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: const Text(
                      ' Pay through Esewa',
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
                            clientId: "LRwIEhEfDh1ZNQURWUE/HwFXXx0QGw0=",
                            secretId: "WBYWEhYSRQ0WCBYVGwQL",
                          ),
                          esewaPayment: EsewaPayment(
                            productId: nameC.text,
                            productName: nameC.text,
                            productPrice: priceC.text,
                            callbackUrl: "www.test-url.com",
                          ),
                          onPaymentSuccess: (EsewaPaymentSuccessResult data) {
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
                            debugPrint(":::CANCELLATION::: => $data");
                            Navigator.pop(context);
                          },
                        );
                      } on Exception catch (e) {
                        debugPrint("EXCEPTION : ${e.toString()}");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
