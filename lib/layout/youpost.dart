import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/resources/seller.dart';
import 'package:Homeplex/widgets/loading_widget.dart';
import '../widgets/products_showcase_list_view.dart';

class YourPost extends StatefulWidget {
  const YourPost({Key? key}) : super(key: key);
  @override
  State<YourPost> createState() => _YourPostState();
}

class _YourPostState extends State<YourPost> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void getData() async {
    List<Widget> temp70 = await CloudFirestoreSellerClass()
        .getProductsofseller(firebaseAuth.currentUser!.uid);
    setState(() {
      discount70 = temp70;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();

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
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.5,
          backgroundColor: Colors.teal,
          title: const Text(
            "  Your Post",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        body: discount70 != null
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
                                "Manage Your Post",
                                style: GoogleFonts.changa(
                                  textStyle: const TextStyle(
                                      color: Color(0xff0E4d92), fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ProductsShowcaseListView(children: discount70!),
                        const Divider(
                          color: Colors.teal,
                          thickness: 0.2,
                        ),
                      ],
                    ),
                  ),
                  // UserDetailsBar(
                  //   offset: offset,
                  // ),
                ],
              )
            : const LoadingWidget(),
      )
    ]);
  }
}
