
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/models/book_mechanic_model.dart';
import 'package:fyp/screens/book_mechanic_screen.dart';
import 'package:fyp/screens/mechanic_screens/drawer/navigation_drawer_screen.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/userModel.dart';
import '../../services/database.dart';
import '../../utils/fonts.dart';
import '../../widgets/buttons.dart';
import '../chat/views/conversationScreen.dart';
import 'package:geolocator/geolocator.dart';



class MechanicInboxScreen extends StatefulWidget {
  const MechanicInboxScreen({Key? key}) : super(key: key);

  @override
  State<MechanicInboxScreen> createState() => _MechanicInboxScreenState();
}

class _MechanicInboxScreenState extends State<MechanicInboxScreen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('ChatRoom').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('ChatRoom').snapshots();
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
          title: const Text("Inbox"),
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
                            (streamSnapshot
                                .data
                                ?.docs[index].id.split("_")[0]
                                ==
                                loggedInUser.fullName || streamSnapshot
                                .data
                                ?.docs[index].id.split("_")[1]
                                ==
                                loggedInUser.fullName)
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
                                      (loggedInUser.fullName==streamSnapshot.data?.docs[index].id.split("_")[0])?
                                      Text(
                                        "${streamSnapshot.data?.docs[index].id.split("_")[1]}",
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            15),
                                      ):Text(
                                        "${streamSnapshot.data?.docs[index].id.split("_")[0]}",
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
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
                                                  "${streamSnapshot.data?.docs[index].id.split("_")[0]}","${streamSnapshot.data?.docs[index].id.split("_")[1]}");


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
