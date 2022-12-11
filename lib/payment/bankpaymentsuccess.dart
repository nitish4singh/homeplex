import 'package:Homeplex/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BankPaymentSuccessScreen extends StatefulWidget {
  const BankPaymentSuccessScreen({Key? key}) : super(key: key);
  @override
  State<BankPaymentSuccessScreen> createState() =>
      _BankPaymentSuccessScreenState();
}

class _BankPaymentSuccessScreenState extends State<BankPaymentSuccessScreen> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 180,
              padding: const EdgeInsets.all(35),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            const Text(
              "Thank You!",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            const Text(
              "Successfully Uploaded your payment record",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            const Text(
              "Our team will soon activate your service \n after verify your payment ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
              child: const Text(
                '  Go to Home Page ',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
              ),
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
      ),
    );
  }
}
