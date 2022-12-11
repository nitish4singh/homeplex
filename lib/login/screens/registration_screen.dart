import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/login/phonelogin.dart';
import 'package:Homeplex/login/screens/login_screen.dart';
import 'package:Homeplex/main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final String role = 'user';
  final String payment = 'no';
  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    passwordEditingController.dispose();
    phoneEditingController.dispose();
    confirmPasswordEditingController.dispose();
    emailEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // name field
    final firstNameField = Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0E4d92),
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    autofocus: false,
                    controller: nameEditingController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("First Name cannot be Empty");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nameEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xff0E4d92),
                      ),
                      hintText: "Name",
                      border: InputBorder.none,
                    )))));

    //phone name field
    final phoneNameField = Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0E4d92),
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    autofocus: false,
                    controller: phoneEditingController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("phone Number cannot be Empty");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xff0E4d92),
                      ),
                      hintText: "Phone Number",
                      border: InputBorder.none,
                    )))));

    //email field
    final emailField = Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0E4d92),
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    autofocus: false,
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color(0xff0E4d92),
                      ),
                      hintText: "Email",
                      border: InputBorder.none,
                    )))));

    //password field
    final passwordField = Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0E4d92),
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    autofocus: false,
                    controller: passwordEditingController,
                    obscureText: true,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                    },
                    onSaved: (value) {
                      passwordEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color(0xff0E4d92),
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                    )))));

    //confirm password field
    final confirmPasswordField = Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff0E4d92),
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                    autofocus: false,
                    controller: confirmPasswordEditingController,
                    obscureText: true,
                    validator: (value) {
                      if (confirmPasswordEditingController.text !=
                          passwordEditingController.text) {
                        return "Password don't match";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      confirmPasswordEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color(0xff0E4d92),
                      ),
                      hintText: " conform Password",
                      border: InputBorder.none,
                    )))));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: Colors.teal,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: const Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          " Register  ",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 150,
                        child: Image.asset(
                          "assets/logo3.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 15),
                    firstNameField,
                    const SizedBox(height: 15),
                    phoneNameField,
                    const SizedBox(height: 15),
                    emailField,
                    const SizedBox(height: 15),
                    passwordField,
                    const SizedBox(height: 15),
                    confirmPasswordField,
                    const SizedBox(height: 15),
                    signUpButton,
                    const SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text(
                              "Login ",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )
                        ]),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Text(
                        "or",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterScreenphone()));
                      },
                      label: const Text(
                        "  Register using PhoneNumber",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 3, 133, 194),
                        fixedSize: const Size(700, 43),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        // print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.role = role.toString();
    userModel.payment = payment.toString();
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false);
  }
}
