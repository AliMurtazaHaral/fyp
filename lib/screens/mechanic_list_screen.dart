import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/models/book_mechanic_model.dart';
import 'package:fyp/screens/book_mechanic_screen.dart';
import 'package:fyp/screens/loading_screen.dart';
import 'package:geocoding/geocoding.dart';
import '../models/userModel.dart';
import '../services/database.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';
import 'chat/views/conversationScreen.dart';
import 'map_screens/distance_calculator_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  createChatRoomAndStartConversation(String userName, String myName,String uid,String uid2) {
    List<String> users = [myName, userName];
    String chatRoomId = getChatRoomId(uid, uid2);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomId": chatRoomId,
    };
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(
            chatRoomId: chatRoomId, myName: myName, userName: userName, currentU: user!.uid,),
      ),
    );
  }
  bool flag = true;
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
    return flag==false?LoadingScreen():Scaffold(
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
                        FilterButton.filterButton(context, "Diesel Engine Mechanic",
                            onTap: () {
                          _runFilter("Diesel Engine Mechanic");
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
                        FilterButton.filterButton(context, "Dentar and Painter",
                            onTap: () {
                          _runFilter("Dentar and Painter");
                        }),

                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(context, "Tire Puncture",
                            onTap: () {
                          _runFilter("Tire Puncture");
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
                        FilterButton.filterButton(
                            context, "AC Repairer", onTap: () {
                          _runFilter("AC Reapirer");
                        }),

                        SizedBox(
                          width: 10,
                        ),
                        FilterButton.filterButton(
                            context, "Petrol Engine Mechanic", onTap: () {
                          _runFilter("Petrol Engine Mechanic");
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
                                                              RatingBar.builder(
                                                                itemSize: 15,
                                                                initialRating: double.parse(streamSnapshot.data?.docs[index]['rating']),
                                                                minRating: 1,
                                                                direction: Axis.horizontal,
                                                                allowHalfRating: false,
                                                                itemCount: 5,
                                                                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                                                                itemBuilder: (context, _) => Icon(
                                                                  Icons.star,
                                                                  color: Colors.amber,
                                                                ),
                                                                onRatingUpdate: (rating) {
                                                                  setState((){

                                                                  });
                                                                  print(rating);
                                                                },

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
                                                                              .toString(),'${streamSnapshot.data?.docs[index].id}',user!.uid);
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

                                                                      setState((){
                                                                        flag = false;
                                                                      });
                                                                      p = await _determinePosition();
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
                                                                      final Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                                                      postDetailsToFirestore(
                                                                          streamSnapshot.data?.docs[index]
                                                                              [
                                                                              'fullName'],
                                                                          loggedInUser
                                                                              .fullName
                                                                              .toString(),
                                                                          Address,
                                                                          "Cash on the spot",streamSnapshot.data?.docs[index].id);

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

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  postDetailsToFirestore(String mechanicName, String customerName,
      String address, String paymentType,String? uid) async {
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

    setState((){
      flag = true;
    });
    Fluttertoast
        .showToast(
        msg: "Mechanic has been booked successfully");
    gotoBookingScreen(address,customerName,mechanicName,uid);
  }

  gotoBookingScreen(String address,String userName,String mechanicName,String? uid){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMechanicScreen(
      mechanicName: mechanicName,
      customerName: userName,
      status: 'Pending',
      address: address,uniId:uid)));
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
