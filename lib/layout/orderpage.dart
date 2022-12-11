import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/cloudlabour.dart';
import 'package:Homeplex/screens/home_screen.dart';
import 'package:Homeplex/transportation/database.dart';
import 'package:Homeplex/widgets/loading_widget.dart';
import '../widgets/products_showcase_list_view.dart';

class Orderpage extends StatefulWidget {
  const Orderpage({Key? key}) : super(key: key);
  @override
  State<Orderpage> createState() => _OrderpageState();
}

class _OrderpageState extends State<Orderpage> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? order70;
  List<Widget>? labourorder80;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void getOrderData() async {
    List<Widget> temp80 =
        await TransportCloudFirestoreClass().getProductsOfCostumer(
      firebaseAuth.currentUser!.uid,
    );
    setState(() {
      order70 = temp80;
    });
  }

  void getLabourOrderData() async {
    List<Widget> temp90 = await LabourCloudFirestoreClass().getProductsOfLabour(
      firebaseAuth.currentUser!.uid,
    );
    setState(() {
      labourorder80 = temp90;
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderData();
    getLabourOrderData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              }),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.5,
          backgroundColor: Colors.teal,
          title: const Text(
            "  Your order",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        body: order70 != null && labourorder80 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 0.0, 5.0, 1.0),
                              child: Text(
                                "Manage Your Order",
                                style: GoogleFonts.changa(
                                  textStyle: const TextStyle(
                                      color: Color(0xff0E4d92), fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ProductsShowcaseListView(children: order70!),
                        const Divider(
                          color: Colors.teal,
                          thickness: 0.2,
                        ),
                        ProductsShowcaseListView(children: labourorder80!),
                      ],
                    ),
                  ),
                ],
              )
            : const LoadingWidget(),
      )
    ]);
  }
}
