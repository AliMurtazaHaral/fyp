import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/models/book_mechanic_model.dart';
import 'package:fyp/screens/book_mechanic_screen.dart';
import 'package:geocoding/geocoding.dart';
import '../models/userModel.dart';
import '../services/database.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';
import 'chat/views/conversationScreen.dart';
import 'map_screens/distance_calculator_screen.dart';
import 'package:geolocator/geolocator.dart';

class MechanicListScreen extends StatefulWidget {
  const MechanicListScreen({Key? key}) : super(key: key);

  @override
  State<MechanicListScreen> createState() => _MechanicListScreenState();
}

class _MechanicListScreenState extends State<MechanicListScreen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
      FirebaseFirestore.instance.collection('users').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
      FirebaseFirestore.instance.collection('users').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoomAndStartConversation(String userName, String myName) {
    List<String> users = [myName, userName];
    String chatRoomId = getChatRoomId(myName, userName);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(
            chatRoomId: chatRoomId, myName: myName, userName: userName),
      ),
    );
  }

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
      appBar: AppBar(
          actions: [],
          backgroundColor: primaryColor,
          title: const Text("All Mechanics"),
          bottom: PreferredSize(
            preferredSize: Size(2, 100),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.white,
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      children: [
                        FilterButton.filterButton(context, "All", onTap: () {
                          _runFilter("");
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Diesel Mechanic",
                            onTap: () {
                          _runFilter("Diesel Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "General Automotive Mechanic", onTap: () {
                          _runFilter("General Automotive Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Breaks and Transmission Technician",
                            onTap: () {
                          _runFilter("Breaks and Transmission Technician");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Auto Body Mechanic",
                            onTap: () {
                          _runFilter("Auto Body Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Race Car Mechanic",
                            onTap: () {
                          _runFilter("Race Car Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Service Technician",
                            onTap: () {
                          _runFilter("Service Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Auto Glass Mechanic", onTap: () {
                          _runFilter("Auto Glass Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Heavy Equipment Mechanic", onTap: () {
                          _runFilter("Heavy Equipment Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Air Craft Mechanic",
                            onTap: () {
                          _runFilter("Air Craft Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Small Engine Mechanic", onTap: () {
                          _runFilter("Small Engine Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Marine Mechanic",
                            onTap: () {
                          _runFilter("Marine Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Tire Mechanic",
                            onTap: () {
                          _runFilter("Tire Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Motorcycle Mechanic", onTap: () {
                          _runFilter("Motorcycle Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Boat Mechanic",
                            onTap: () {
                          _runFilter("Boat Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Bicycle Mechanic",
                            onTap: () {
                          _runFilter("Bicycle Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Air Conditioning Mechanic", onTap: () {
                          _runFilter("Air Conditioning Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Plumbing Mechanic",
                            onTap: () {
                          _runFilter("Plumbing Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Line Mechanic",
                            onTap: () {
                          _runFilter("Line Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Auto Exhaust Mechanic", onTap: () {
                          _runFilter("Auto Exhaust Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Aftermarket Mechanic", onTap: () {
                          _runFilter("Aftermarket Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Welding Mechanic",
                            onTap: () {
                          _runFilter("Welding Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Welding Mechanic",
                            onTap: () {
                          _runFilter("Welding Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Motorcycle Engine Mechanic", onTap: () {
                          _runFilter("Motorcycle Engine Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Motorcycle Technician", onTap: () {
                          _runFilter("Motorcycle Technician");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Motorcycle Service Technician",
                            onTap: () {
                          _runFilter("Motorcycle Service Technician");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Carburetor Mechanic", onTap: () {
                          _runFilter("Carburetor Mechanic");
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Heavy Bike Mechanic", onTap: () {
                          _runFilter("Heavy Bike Mechanic");
                        }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
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
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Expanded(
                          child: streamSnapshot.data?.docs.length != 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: streamSnapshot.data?.docs.length,
                                  itemBuilder:
                                      (ctx, index) =>
                                          streamSnapshot
                                                      .data
                                                      ?.docs[index]
                                                          ['profession']
                                                      .toString() ==
                                                  'Mechanic'
                                              ? Container(

                                                  decoration: BoxDecoration(
                                                    color: secondaryColor,
                                                    border: Border.all(
                                                        color: primaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0xFFFAC213),
                                                        spreadRadius: 2,
                                                        blurRadius: 4,
                                                        offset: Offset(3, 3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.only(bottom: 30),
                                                  child:
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .3,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .15,
                                                            color: Colors.grey,
                                                            child: Icon(
                                                                Icons.person),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                .02,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${streamSnapshot.data?.docs[index]['fullName']}",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              const Text(
                                                                "5 star Rating",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    .02,
                                                              ),
                                                              Row(

                                                                children: [
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                        .08,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      createChatRoomAndStartConversation(
                                                                          streamSnapshot.data?.docs[index]
                                                                              [
                                                                              'fullName'],
                                                                          loggedInUser
                                                                              .fullName
                                                                              .toString());
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black,
                                                                          borderRadius:
                                                                              BorderRadius.circular(0.0)),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16.0,
                                                                          vertical:
                                                                              16.0),
                                                                      child: const Text(
                                                                          'Message',
                                                                          style: TextStyle(
                                                                              color: Color(0xFFFAC213),
                                                                              fontSize: 10)),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .02,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      p = await _determinePosition();
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "Mechanic has been booked successfully");
                                                                      List<Placemark>
                                                                          placemarks =
                                                                          await placemarkFromCoordinates(
                                                                              p.latitude,
                                                                              p.longitude);
                                                                      print(
                                                                          placemarks);
                                                                      Placemark
                                                                          place =
                                                                          placemarks[
                                                                              0];
                                                                      final Address =
                                                                          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                                                      postDetailsToFirestore(
                                                                          streamSnapshot.data?.docs[index]
                                                                              [
                                                                              'fullName'],
                                                                          loggedInUser
                                                                              .fullName
                                                                              .toString(),
                                                                          Address,
                                                                          "Cash on the spot");
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => BookMechanicScreen(
                                                                                    mechanicName: streamSnapshot.data?.docs[index]['fullName'],
                                                                                    customerName: loggedInUser.fullName.toString(),
                                                                                    status: 'Pending',
                                                                                    address: Address,
                                                                                  )));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black,
                                                                          borderRadius:
                                                                              BorderRadius.circular(0.0)),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16.0,
                                                                          vertical:
                                                                              16.0),
                                                                      child: const Text(
                                                                          'Book',
                                                                          style: TextStyle(
                                                                              color: Color(0xFFFAC213),
                                                                              fontSize: 10)),
                                                                    ),
                                                                  ),
                                                                ],
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                )
                                              : const Text(
                                                  '',
                                                  style:
                                                      TextStyle(fontSize: 0),
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
      ),
    );
  }

  late Position p;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  postDetailsToFirestore(String mechanicName, String customerName,
      String address, String paymentType) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    BookMechanicModel userModel = BookMechanicModel();

    // writing all the values

    userModel.customerName = customerName;
    userModel.mechanicName = mechanicName;
    userModel.paymentType = paymentType;
    userModel.currentLocation = address;
    userModel.status = "Pending";

    await firebaseFirestore
        .collection("book_mechanic")
        .doc()
        .set(userModel.toMapBooking());
    Fluttertoast.showToast(msg: "Your account has been created successfully");
  }

  void _runFilter1() {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
        FirebaseFirestore.instance.collection('users').snapshots();
    // we use the toLowerCase() method to make it case-insensitive
    results = FirebaseFirestore.instance
        .collection('users')
        .where('profession'.toString(), isEqualTo: "Mechanic")
        .snapshots();
  }

  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
        FirebaseFirestore.instance.collection('users').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allMechanic;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('users')
          .where('category'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      foundMechanic = results;
    });
  }
}
