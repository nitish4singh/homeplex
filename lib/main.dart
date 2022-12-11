import 'dart:async';
import 'package:Homeplex/login/screens/registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/watertanker/driver/tankerdriverhomecreen.dart';
import 'package:provider/provider.dart';
import 'package:Homeplex/providers/user_details_provider.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:Homeplex/transportation/driver/driverhomecreen.dart';
import 'package:Homeplex/utils/color_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD_GZyRC7Q3yUP-bA4TWTiY5dciQjEHHVE",
            authDomain: "Homeplex4488.firebaseapp.com",
            projectId: "Homeplex4488",
            storageBucket: "Homeplex4488.appspot.com",
            messagingSenderId: "334758601578",
            appId: "1:334758601578:web:d1919af2107779319b7b13",
            measurementId: "G-B51YMQH3T8"));
  } else {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  runApp(const Homeplex());
}

class Homeplex extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  const Homeplex({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider())
      ],
      child: MaterialApp(
        title: "Homeplex",
        navigatorObservers: <NavigatorObserver>[observer],
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const SplashScreen();
              } else {
                return const RegistrationScreen();
              }
            }),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateNext(Widget route) {
    Timer(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
    });
  }

  String role = 'user';
  void _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      role = snap['role'];
    });

    if (role == 'user') {
      navigateNext(const HomeScreen());
    } else if (role == 'driver') {
      navigateNext(const DriverScreen());
    } else if (role == 'tanker') {
      navigateNext(const WatertankerDriverScreen());
    } else {
      navigateNext(const HomeScreen());
    }
  }

//ScreenLayout
//DriverHomeScreen
  @override
  void initState() {
    super.initState();
    _checkRole();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      // <-- STACK AS THE SCAFFOLD PARENT
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/b1.png"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          //backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/logo3.png',
                  width: 340,
                  height: 280,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.teal,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                  child: Text(
                    'From Smarttrix',
                    style: GoogleFonts.changa(
                      textStyle:
                          const TextStyle(color: Colors.teal, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
