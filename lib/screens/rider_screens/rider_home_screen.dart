import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/shoped_products.dart';


import '../../models/userModel.dart';
import '../../services/database.dart';
import '../../utils/fonts.dart';
import '../chat/views/conversationScreen.dart';
import '../map_screens/distance_calculator_screen.dart';
import '../map_screens/map_utils.dart';
import 'drawer/navigation_drawer_screen.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({Key? key}) : super(key: key);

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  String url = "";
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
      FirebaseFirestore.instance.collection('shoped_products').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
      FirebaseFirestore.instance.collection('shoped_products').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .2,
            decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Center(
              child: Text(
                "All Delivery Request",
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1,
              color: secondaryColor,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    height: MediaQuery.of(context).size.height * 1,
                    child: StreamBuilder(
                      stream: foundMechanic,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 200),
                          child: Expanded(
                            child: streamSnapshot.data?.docs.length != 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: streamSnapshot.data?.docs.length,
                                    itemBuilder: (ctx, index) =>
                                        streamSnapshot.data!.docs[index]
                                                    ["riderName"] ==
                                                ""
                                            ? Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 0),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Column(
                                                          children: [
                                                            Image(
                                                              image: AssetImage(
                                                                  "assets/images/map.jpg"),
                                                              height: 220,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .02,
                                                            ),
                                                            Text(
                                                              "Product Name: ${streamSnapshot.data?.docs[index]['productName']}",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .02,
                                                            ),
                                                            Text(
                                                              "Product Price: ${streamSnapshot.data?.docs[index]['productPrice']}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .02,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                MapUtils.launchMapUrl(
                                                                    streamSnapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                        [
                                                                        'pickupPoint']);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0,
                                                                    vertical:
                                                                        16.0),
                                                                child: const Text(
                                                                    'Navigate to Shop',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .02,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                final _auth =
                                                                    FirebaseAuth
                                                                        .instance;

                                                                FirebaseFirestore
                                                                    firebaseFirestore =
                                                                    FirebaseFirestore
                                                                        .instance;
                                                                User? user = _auth
                                                                    .currentUser;
                                                                ShopedProductModel
                                                                    userModel =
                                                                    ShopedProductModel();

                                                                // writing all the values

                                                                userModel
                                                                        .riderName =
                                                                    loggedInUser
                                                                        .fullName
                                                                        .toString();

                                                                await firebaseFirestore
                                                                    .collection(
                                                                        "shoped_products")
                                                                    .doc(streamSnapshot.data!.docs[index].id)
                                                                    .update(userModel
                                                                        .toMapShopedProductChangeRiderName());
                                                                Navigator.pushNamed(context, '/riderEarning');
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0,
                                                                    vertical:
                                                                        16.0),
                                                                child: const Text(
                                                                    'Book this Delivery',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .02,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                MapUtils.launchMapUrl(
                                                                    streamSnapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                        [
                                                                        'deliveryPoint']);
                                                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDetailScreen(mechanicName: streamSnapshot.data?.docs[index]['mechanicName'], customerName: streamSnapshot.data?.docs[index]['customerName'], status: streamSnapshot.data?.docs[index]['status'], address: streamSnapshot.data?.docs[index]['currentLocation'],id:streamSnapshot.data?.docs[index].id)));
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0,
                                                                    vertical:
                                                                        16.0),
                                                                child: const Text(
                                                                    'Navigate to Delivery Point',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  .02,
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Divider(
                                                    height: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .2,
                                                  ),
                                                ],
                                              )
                                            : const Text(
                                                '',
                                                style: TextStyle(fontSize: 0),
                                              ),
                                  )
                                : const Text(
                                    'No results found',
                                    style: TextStyle(fontSize: 24),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
