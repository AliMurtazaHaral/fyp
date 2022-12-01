import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/map_screens/map_utils.dart';
import 'package:fyp/screens/mechanic_screens/booking_detail_screen.dart';
import 'package:fyp/screens/mechanic_screens/drawer/navigation_drawer_screen.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/utils/fonts.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../models/userModel.dart';
import '../chat/views/conversationScreen.dart';

class MechanicHomeScreen extends StatefulWidget {
  const MechanicHomeScreen({Key? key}) : super(key: key);

  @override
  State<MechanicHomeScreen> createState() => _MechanicHomeScreenState();
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  String url = "";
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
      FirebaseFirestore.instance.collection('book_mechanic').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
      FirebaseFirestore.instance.collection('book_mechanic').snapshots();
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
                "All Bookings",
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
                                    streamSnapshot.data!.docs[index]["mechanicName"]
                                        ==loggedInUser.fullName && streamSnapshot.data!.docs[index]["status"]=="Pending"?
                                    Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          decoration: const BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                Radius.circular(10),
                                                topRight:
                                                Radius.circular(10),
                                                bottomLeft:
                                                Radius.circular(10),
                                                bottomRight:
                                                Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.yellow,
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(10),
                                                          topRight:
                                                          Radius.circular(10),
                                                          bottomLeft:
                                                          Radius.circular(10),
                                                          bottomRight:
                                                          Radius.circular(10)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.yellow,
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/images/map.jpg"),
                                                      height: 220,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        .02,
                                                  ),
                                                  Text(
                                                    "Customer Name: ${streamSnapshot.data?.docs[index]['customerName']}",
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
                                                    "${streamSnapshot.data?.docs[index]['currentLocation']}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        .02,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          MapUtils.launchMapUrl(
                                                              streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              [
                                                              'currentLocation']);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  30.0)),
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              16.0,
                                                              vertical:
                                                              16.0),
                                                          child: const Text(
                                                              'Navigate',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDetailScreen(mechanicName: streamSnapshot.data?.docs[index]['mechanicName'], customerName: streamSnapshot.data?.docs[index]['customerName'], status: streamSnapshot.data?.docs[index]['status'], address: streamSnapshot.data?.docs[index]['currentLocation'],id:streamSnapshot.data?.docs[index].id)));
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  30.0)),
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              16.0,
                                                              vertical:
                                                              16.0),
                                                          child: const Text(
                                                              'See Details',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ],
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
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              .2,
                                        ),
                                      ],
                                    ):Text('',style: TextStyle(fontSize: 0),))
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
