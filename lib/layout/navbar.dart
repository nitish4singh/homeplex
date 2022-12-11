import 'package:Homeplex/payment/firstpagepayment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/layout/complain.dart';
import 'package:Homeplex/layout/favourate.dart';
import 'package:Homeplex/layout/privacypolicy.dart';
import 'package:Homeplex/layout/profile.dart';
import 'package:Homeplex/layout/term_&_condition.dart';
import 'package:Homeplex/layout/youpost.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/login/screens/login_screen.dart';
import '../labourservice/houseinspectionfirstpage.dart';
import 'orderpage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void getuserdata() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //  padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 135.0,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.teal,
                    //  Color(0xffb70855),
                    Colors.teal,
                  ],
                ),
              ),
              currentAccountPicture: Container(
                  padding: const EdgeInsets.all(50.0),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      "assets/logo3.png",
                    ),
                    fit: BoxFit.fill,
                  ))),
              accountName: Text(' ${loggedInUser.phone} '),
             accountEmail: Text(' ${loggedInUser.name} '),
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Color(0xff9b0b79),
              ),
              title: const Text(
                'Your Intrest',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavorateScreen(),
                    ));
              }),
          ListTile(
              leading: const Icon(Icons.post_add, color: Colors.blue),
              title: const Text(
                'Your Order',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Orderpage(),
                    ));
              }),
          ListTile(
              leading: const Icon(Icons.post_add, color: Colors.blue),
              title: const Text(
                'Your Post',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YourPost(),
                    ));
              }),
          ListTile(
            leading: const Icon(Icons.message, color: Colors.blue),
            title: const Text('Your complain/support service',
                style: TextStyle(color: Colors.teal)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComplainService(),
                  ));
            },
          ),
          ListTile(
              leading: const Icon(Icons.payment, color: Colors.blue),
              title: const Text(
                'Payment',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentFirstPage(),
                    ));
              }),
          ListTile(
              leading: const Icon(Icons.engineering, color: Colors.blue),
              title: const Text(
                'Engineer Expert',
                style: TextStyle(color: Colors.teal),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HouseInspectionFirstP(),
                    ));
              }),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Account', style: TextStyle(color: Colors.teal)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
          ),
          ListTile(
              leading: const Icon(Icons.description, color: Colors.blue),
              title: const Text('All Privacy Policy',
                  style: TextStyle(color: Colors.teal)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PolicyDialog(),
                    ));
              }),
          ListTile(
              leading: const Icon(
                Icons.description,
                color: Colors.blue,
              ),
              title: const Text('Tearms & Condition',
                  style: TextStyle(color: Colors.teal)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TearmsCondiion(),
                    ));
              }),
          ListTile(
              title: const Text('Signout', style: TextStyle(color: Colors.red)),
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onTap: () {
                logout(context);
              }),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
