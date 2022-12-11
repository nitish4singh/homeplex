import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import '../widgets/loading_widget.dart';
import '../widgets/results_widget.dart';
import '../widgets/search_bar_widget.dart';

class ResultsScreen extends StatefulWidget {
  final String query;

  const ResultsScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    String searchKey =
        widget.query[0].toUpperCase() + widget.query.substring(1);
    return Stack(children: [
      SafeArea(
          child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Showing results for    ",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      TextSpan(
                        text: widget.query,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.red,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('rentProperty')
                        .orderBy("tracelocation")
                        .startAt([searchKey]).endAt(
                            [searchKey + '\uf8ff']).get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              RentModel product = RentModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                              return ResultsWidget(productModel: product);
                            });
                      }
                    }))
          ],
        ),
      ))
    ]);
  }
}
