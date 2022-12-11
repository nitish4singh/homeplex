import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/layout/complain.dart';
import 'package:Homeplex/layout/privacypolicy.dart';
import 'package:Homeplex/layout/profile.dart';
import 'package:Homeplex/layout/term_&_condition.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/login/screens/login_screen.dart';

class DriverNavBar extends StatefulWidget {
  const DriverNavBar({Key? key}) : super(key: key);

  @override
  State<DriverNavBar> createState() => _DriverNavBarState();
}

class _DriverNavBarState extends State<DriverNavBar> {
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
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(' ${loggedInUser.name} '),
            accountEmail: Text(' ${loggedInUser.phone} '),
            // currentAccountPicture: CircleAvatar(
            //   child: ClipOval(
            //     child: Image.network(
            //       loggedInUser.profilePic,
            //       fit: BoxFit.cover,
            //       width: 90,
            //       height: 90,
            //     ),
            //   ),
            // ),
            decoration: const BoxDecoration(
              color: Colors.teal,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.message, color: Colors.blue),
            title: const Text('Your complain',
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
