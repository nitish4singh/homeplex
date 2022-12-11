import 'dart:io';
import 'dart:typed_data';
import 'package:Homeplex/payment/bankpaymentsuccess.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class OtherBanking extends StatefulWidget {
  const OtherBanking({Key? key}) : super(key: key);
  @override
  State<OtherBanking> createState() => _OtherBankingState();
}

class _OtherBankingState extends State<OtherBanking> {
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController worktypeC = TextEditingController();
  DateTime CurrentDate = DateTime.now();
  String pasteValue = '';
  final formKey = GlobalKey<FormState>();
  bool selection = false;
  String? downloadUrl;
  String? profilePic;

  var path =
      'https://firebasestorage.googleapis.com/v0/b/homeplex-3b1ff.appspot.com/o/payment%2FWhatsApp%20Image%202022-09-30%20at%2022.11.53.jpeg?alt=media&token=c09ba3a3-7d03-4f7a-a289-21b6b51b6109';
  void saveimage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio()
          .get(path, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "Homeplexqrcode");
      _showSnackBarimage();
      print(result);
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
          //  priceC.text = snapshot['price'];
          // worktypeC.text = snapshot['worktype'];
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
          "Other Banking",
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
                  const SizedBox(
                    height: 18,
                  ),
                  Image.network(
                    path,
                    height: 280,
                    width: 300,
                    // fit: BoxFit.cover,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        saveimage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.yellow, // foreground
                      ),
                      child: const Text('Download qr & pay')),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Or',
                      style: GoogleFonts.changa(
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            letterSpacing: .1,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Company Bank Detail',
                      style: GoogleFonts.changa(
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            letterSpacing: .1,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'NIC Asia Bank',
                      style: GoogleFonts.changa(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .1,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                          primary: Colors.white,
                          //  backgroundColor: Colors.teal,
                          onSurface: Colors.grey,
                        ),
                        child: const Text(
                          'HOME PLEX PRIVATE LIMITED',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _copyaccountname();
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: const Icon(Icons.copy,
                            color: Colors.orange, size: 32),
                        onTap: () {
                          _copyaccountname();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(30, 7, 30, 7),
                          primary: Colors.white,
                          onSurface: Colors.grey,
                        ),
                        child: const Text(
                          '0334150073912003',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          _copyaccountno();
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: const Icon(Icons.copy,
                            color: Colors.orange, size: 32),
                        onTap: () {
                          _copyaccountno();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Upload Your Payment Details',
                      style: GoogleFonts.changa(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .2,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.teal,
                    thickness: 0.1,
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        color: Colors.grey[100]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Upload your Payment ScreenShot',
                            style: GoogleFonts.baloo2(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .2,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              final XFile? pickImage =
                                  await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 65,
                              );
                              if (pickImage != null) {
                                setState(() {
                                  profilePic = pickImage.path;
                                  selection = true;
                                });
                              }
                            },
                            child: Container(
                                child: profilePic == null
                                    ? Container(
                                        padding: const EdgeInsets.all(50),
                                        height: 200,
                                        child: Image.asset(
                                          'assets/noimage.png',
                                          // fit: ,
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(50.0),
                                        height: 300,
                                        child: Image.file(File(profilePic!)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  !isSaving
                      ? TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                            primary: Colors.white,
                            backgroundColor: Colors.teal,
                            onSurface: Colors.grey,
                          ),
                          child: const Text(
                            ' Upload Payment Detail',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            saveInfo();
                          },
                        )
                      : const SpinKitWave(
                          color: Colors.orange,
                        ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _copyaccountno() {
    FlutterClipboard.copy('0334150073912003').then((value) {
      _showSnackBaraccountno();
    });
  }

  void _copyaccountname() {
    FlutterClipboard.copy('HOME PLEX PRIVATE LIMITED').then((value) {
      _showSnackBaraccountname();
    });
  }

  void _showSnackBaraccountname() {
    const snack = SnackBar(
        content: Text("Account Holder name Copied"),
        padding: EdgeInsets.all(30.0),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 300.0),
        duration: Duration(seconds: 4));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void _showSnackBaraccountno() {
    const snack = SnackBar(
        content: Text("Account number copied"),
        padding: EdgeInsets.all(30.0),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 300.0),
        duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void _showSnackBarimage() {
    const snack = SnackBar(
        content: Text("FonePay Qr code saved on your phone \n scan and pay "),
        padding: EdgeInsets.all(30.0),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 300.0),
        duration: Duration(seconds: 6));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  saveInfo() {
    setState(() {
      isSaving = true;
    });
    uploadImage(File(profilePic!), 'otherbanking').whenComplete(() {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'phone': phoneC.text,
        'paymentScreenshot': downloadUrl,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'verifyPayment': 'no'.toString(),
        'datetime': CurrentDate.toString(),
        "paymentmode": 'otherBanking'.toString(),
      };
      FirebaseFirestore.instance
          .collection('payment')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        setState(() {
          isSaving = false;
        });

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BankPaymentSuccessScreen(),
            ));
      });
    });
  }
}
