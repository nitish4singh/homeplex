import 'package:Homeplex/payment/esawa.dart';
import 'package:Homeplex/payment/otherbankingpayment.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentFirstPage extends StatefulWidget {
  const PaymentFirstPage({Key? key}) : super(key: key);
  @override
  State<PaymentFirstPage> createState() => _PaymentFirstPageState();
}

class _PaymentFirstPageState extends State<PaymentFirstPage> {
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
          "  Payment",
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 15, 90, 15),
                    child: TextButton(
                      child: Row(children: [
                        const Text('Pay with  '),
                        Image.asset(
                          'assets/logo.png',
                          height: 20,
                        ),
                      ]),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(60, 12, 30, 12),
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Esewapay(),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'or',
                      style: GoogleFonts.changa(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text('Fonepay / Other mobile Banking'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtherBanking(),
                          ));
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
