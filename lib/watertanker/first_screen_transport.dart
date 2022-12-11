import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/watertanker/driver/uploadtankerScreen.dart';
import 'package:Homeplex/watertanker/tankerdatabase.dart';
import 'package:Homeplex/widgets/loading_widget.dart';
import '../transportation/phone.dart';
import '../widgets/products_showcase_list_view.dart';

class TankerFistPage extends StatefulWidget {
  const TankerFistPage({Key? key}) : super(key: key);
  @override
  State<TankerFistPage> createState() => _TankerFistPageState();
}

class _TankerFistPageState extends State<TankerFistPage> {
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
    List<Widget> temp70 =
        await TankerCloudFirestoreClass().getProductsOfTanker("yes");
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
            "  Transportation services  ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          actions: <Widget>[
            Stack(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const WaterTankerUploadScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
        body: discount70 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    // controller: controller,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Container(
                              height: 150.0,
                              width: MediaQuery.of(context).size.width - 40,
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
                                            21.0, 5.0, 5.0, 5.0),
                                        child: Text(
                                          "तपाईलाई के कस्तो, कुन प्रयोजनको लागि टंकर  गाडी चाहिएको छ ? यदि तपाई त्यस बारे जानकार हुनुहुन्छ भने तल उपलब्ध टंकर  हरु मध्ये आफुलाई मन परेको टंकर   छान्नुहोस् | अन्यथा सिधै सम्पर्क गर्न सक्नुहुनेछ |",
                                          style: GoogleFonts.balooBhai2(
                                            textStyle: TextStyle(
                                                color: Colors.red[400],
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        shadowColor: Colors.grey,
                                        margin: const EdgeInsets.all(2),
                                        child: TextButton(
                                          onPressed: () {
                                            customLaunch('tel:+9779862287720');
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
                                'Book According to your wish',
                                style: GoogleFonts.oswald(
                                  textStyle: const TextStyle(
                                      color: Color(0xff0E4d92), fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProductsShowcaseListView(children: discount70!),
                        // ProductsShowcaseListView(children: discount70!),
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
