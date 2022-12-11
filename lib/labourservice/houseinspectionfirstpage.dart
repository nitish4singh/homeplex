import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/houseinspectioncloud.dart';
import 'package:Homeplex/widgets/loading_widget.dart';
import '../transportation/name.dart';
import '../widgets/products_showcase_list_view.dart';

class HouseInspectionFirstP extends StatefulWidget {
  const HouseInspectionFirstP({Key? key}) : super(key: key);
  @override
  State<HouseInspectionFirstP> createState() => _HouseInspectionFirstPState();
}

class _HouseInspectionFirstPState extends State<HouseInspectionFirstP> {
  final List<String> carouselImages = [];
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;

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
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 = await HouseInspectionCloud().gethouseinspection();
    setState(() {
      discount70 = temp70;
    });
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
            "  House Inspecton Service ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        body: discount70 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 10, 5),
                          child: Container(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width - 70,
                              padding: const EdgeInsets.all(0),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 5.5,
                                      blurRadius: 5.5,
                                    )
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20.0, 5.0, 5.0, 5.0),
                                        child: Text(
                                          "For any Enquiry contact",
                                          style: GoogleFonts.changa(
                                            textStyle: const TextStyle(
                                                color: Color(0xff0E4d92),
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 35),
                                      child: Card(
                                        shadowColor: Colors.grey,
                                        margin: const EdgeInsets.all(2),
                                        child: TextButton(
                                          onPressed: () {
                                            customLaunch('tel:+9779851001238');
                                          },
                                          child: const Icon(
                                            Icons.phone,
                                            size: 40,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 1, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Request an Engineer',
                                style: GoogleFonts.oswald(
                                  textStyle: const TextStyle(
                                      color: Color(0xff0E4d92), fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProductsShowcaseListView(children: discount70!),
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
