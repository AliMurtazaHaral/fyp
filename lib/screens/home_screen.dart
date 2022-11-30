
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fyp/screens/top_rated_shops_screen.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 1,
        color: secondaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                ImageSlideshow(

                  height: 200,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    Image.asset(
                      'assets/images/img1.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/img2.jpeg',
                      fit: BoxFit.cover,
                    ),

                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFFAC213),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding, defaultPadding, defaultPadding, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedButton.roundedButton(
                                context,
                                "assets/images/mechanic.png",
                                "Mechanic", onTap: () {
                              Navigator.pushNamed(context, "/mechanicList");
                            }),
                            RoundedButton.roundedButton(
                                context,
                                "assets/images/spare-parts-shop.png",
                                "Spare Part", onTap: () {
                              Navigator.pushNamed(context, "/shopOwnerList");
                            }),
                            RoundedButton.roundedButton(
                                context,
                                "assets/images/car-detection.png",
                                "Car Detection", onTap: () {

                              Navigator.pushNamed(context, "/vehicleDetection");
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding, 0, defaultPadding, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedButton.roundedButton(
                                context,
                                "assets/images/location.png",
                                "Location", onTap: () {
                              Navigator.pushNamed(context, "/map");
                            }),
                            RoundedButton.roundedButton(
                                context,
                                "assets/images/top-rated.png",
                                "Top Rated", onTap: () {
                              Navigator.pushNamed(context, "/topRatedShops");
                            }),
                            RoundedButton.roundedButton(
                                context,
                                "assets/images/wallet.png",
                                "Wallet", onTap: () {
                              Navigator.pushNamed(context, "/paymentStripe");
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
