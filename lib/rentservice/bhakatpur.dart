import 'package:flutter/material.dart';
import 'package:Homeplex/rentservice/rentcloud.dart';
import 'package:Homeplex/screens/results_screen.dart';
import 'package:Homeplex/widgets/loading_widget.dart';
import 'package:Homeplex/widgets/products_showcase_list_view.dart';

class BhaktpurFirstScreen extends StatefulWidget {
  const BhaktpurFirstScreen({Key? key}) : super(key: key);
  @override
  State<BhaktpurFirstScreen> createState() => _BhaktpurFirstScreenState();
}

class _BhaktpurFirstScreenState extends State<BhaktpurFirstScreen>
    with TickerProviderStateMixin {
  List<Widget>? alldata;
  List<Widget>? onlyhouse;
  List<Widget>? onlyflat;
  List<Widget>? onlyroom;
  List<Widget>? onlyshutter;
  List<Widget>? onlyappartment;
  List<Widget>? onlyoffice;
  ScrollController controller = ScrollController();
  double offset = 0;
  @override
  void initState() {
    super.initState();
    getDataAll();
    getDatahouse();
    getDataappartment();
    getDataflat();
    getDataroom();
    getDatashutter();
    getDataOffice();
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

  void getDataAll() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByAllCatogary("bhaktapur", "yes");
    setState(() {
      alldata = temp70;
    });
  }

  void getDatahouse() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByCatogary("bhaktapur", "house", "yes");
    setState(() {
      onlyhouse = temp70;
    });
  }

  void getDataOffice() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByOffice("kathmandu", "office", "yes");
    setState(() {
      onlyoffice = temp70;
    });
  }

  void getDataroom() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByCatogary("bhaktapur", "room", "yes");
    setState(() {
      onlyroom = temp70;
    });
  }

  void getDataflat() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByCatogary("bhaktapur", "flat", "yes");
    setState(() {
      onlyflat = temp70;
    });
  }

  void getDatashutter() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByCatogary("bhaktapur", "shutter", "yes");
    setState(() {
      onlyshutter = temp70;
    });
  }

  void getDataappartment() async {
    List<Widget> temp70 = await RentCloudFirestoreClass()
        .getProductsByCatogary("bhaktapur", "appartment", "yes");
    setState(() {
      onlyappartment = temp70;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 7, vsync: this);
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 1.0),
            child: searchappbar(),
          ),
        ),
        body: alldata != null &&
                onlyappartment != null &&
                onlyflat != null &&
                onlyhouse != null &&
                onlyroom != null &&
                onlyshutter != null &&
                onlyoffice != null
            ? Stack(children: [
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.orange),
                          // indicatorWeight: 8.0,
                          // indicatorColor: Colors.red,
                          unselectedLabelColor: Colors.black,
                          controller: tabController,
                          isScrollable: true,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          tabs: const [
                            Tab(
                              child: Text(
                                " All ",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Room",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Flat",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "House",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Shutter",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Office",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Appartment",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                        child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 1),
                                child: ProductsShowcaseListView(
                                    children: alldata!),
                              );
                            }),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 1),
                                child: ProductsShowcaseListView(
                                    children: onlyroom!),
                              );
                            }),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 10),
                                child: ProductsShowcaseListView(
                                    children: onlyflat!),
                              );
                            }),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 1),
                                child: ProductsShowcaseListView(
                                    children: onlyhouse!),
                              );
                            }),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 1),
                                child: ProductsShowcaseListView(
                                    children: onlyshutter!),
                              );
                            }),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 1),
                                child: ProductsShowcaseListView(
                                    children: onlyoffice!),
                              );
                            }),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 1),
                                child: ProductsShowcaseListView(
                                    children: onlyappartment!),
                              );
                            }),
                      ],
                    ))
                  ],
                ),
              ])
            : const LoadingWidget(),
      )
    ]);
  }

  searchappbar() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.teal,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(0), bottomLeft: Radius.circular(0))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.search,
              color: Color(0xff0E4d92),
            ),
            title: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (String query) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(query: query),
                    ));
              },
              decoration: const InputDecoration(
                hintText: "Search Room by the location",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
