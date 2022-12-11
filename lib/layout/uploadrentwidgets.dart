import 'package:align_positioned/align_positioned.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/screens/sell_screen.dart';
import 'color.dart';

class UploadProperties extends StatefulWidget {
  const UploadProperties({Key? key}) : super(key: key);

  @override
  UploadPropertiesState createState() => UploadPropertiesState();
}

class UploadPropertiesState extends State<UploadProperties> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 2),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.4),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1.8 / 0.7,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shadowColor: AppTheme.borderCard,
              margin: const EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: AppTheme.secondary)),
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 20,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 40,
                                    child: Image.asset(
                                      'assets/room1.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 40,
                                    child: Image.asset(
                                      'assets/shuter1.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 40,
                                    child: Image.asset(
                                      'assets/house.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Flexible(
                                    flex: 20,
                                    child: Icon(
                                      EvaIcons.moreHorizontal,
                                      color: AppTheme.subTitleTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: AppTheme.shadow,
                            thickness: 1,
                          ),
                          Expanded(
                              flex: 20,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                margin:
                                    const EdgeInsets.only(left: 60, right: 16),
                                child: FractionallySizedBox(
                                  heightFactor: 0.55,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 50,
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          elevation: 0,
                                          color: const Color(0xff0E4d92),
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppTheme.radius)),
                                          child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              alignment: Alignment.center,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "  Upload your Properties ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                ),
                                              )),
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 5,
                                      ),
                                      Expanded(
                                        flex: 40,
                                        child: Container(
                                          padding: const EdgeInsets.all(1.0),
                                          width: double.infinity,
                                          child: FractionallySizedBox(
                                            heightFactor: 0.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        child: const FittedBox(
                                                            child: Icon(EvaIcons
                                                                .arrowForward)))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashFactory: InkRipple.splashFactory,
                          splashColor: AppTheme.shadow.withOpacity(0.1),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SellScreen()));
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 5,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                heightFactor: 0.7,
                widthFactor: 0.4,
                child: AlignPositioned(
                  moveByContainerWidth: -0.01,
                  touch: Touch.inside,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: const Color(0xff045362),
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
