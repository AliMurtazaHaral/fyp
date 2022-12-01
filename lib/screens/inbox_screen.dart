import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/models/book_mechanic_model.dart';
import 'package:fyp/screens/book_mechanic_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../services/database.dart';
import '../../utils/fonts.dart';
import '../models/userModel.dart';
import 'chat/views/conversationScreen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
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

  createChatRoomAndStartConversation(String userName, String myName, String uid,String uid2) {
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
      ),
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
                                user!.uid || streamSnapshot
                                .data
                                ?.docs[index].id.split("_")[1]
                                ==
                                user!.uid)
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
                              Padding(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: secondaryColor,

                                      radius: 40, // Image radius
                                      child: Icon(Icons.person),
                                    ),
                                    (loggedInUser.fullName==streamSnapshot.data?.docs[index]['users'][0])?
                                    Text(
                                      "${streamSnapshot.data?.docs[index]['users'][1]}",
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          15),
                                    ):Text(
                                      "${streamSnapshot.data?.docs[index]['users'][0]}",
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize:
                                          15),
                                    ),


                                    GestureDetector(
                                      onTap: () {
                                        if(loggedInUser.fullName==streamSnapshot.data?.docs[index]['users'][0]){
                                          if(user!.uid==streamSnapshot.data?.docs[index].id.split("_")[1]){
                                            createChatRoomAndStartConversation(streamSnapshot.data?.docs[index]['users'][1],loggedInUser.fullName.toString(),
                                                user!.uid,"${streamSnapshot.data?.docs[index].id.split("_")[0]}");
                                          }
                                          else{
                                            createChatRoomAndStartConversation(streamSnapshot.data?.docs[index]['users'][1],loggedInUser.fullName.toString(),
                                                user!.uid,"${streamSnapshot.data?.docs[index].id.split("_")[1]}");
                                          }

                                        }
                                        else{
                                          if(user!.uid==streamSnapshot.data?.docs[index].id.split("_")[1]) {
                                            createChatRoomAndStartConversation(
                                                streamSnapshot.data
                                                    ?.docs[index]['users'][0],
                                                loggedInUser.fullName
                                                    .toString(),
                                                user!.uid,
                                                "${streamSnapshot.data
                                                    ?.docs[index].id.split(
                                                    "_")[0]}");
                                          }
                                          else{
                                            createChatRoomAndStartConversation(
                                                streamSnapshot.data
                                                    ?.docs[index]['users'][0],
                                                loggedInUser.fullName
                                                    .toString(),
                                                user!.uid,
                                                "${streamSnapshot.data
                                                    ?.docs[index].id.split(
                                                    "_")[1]}");
                                          }
                                        }
                                      },
                                      child:Icon(Icons.arrow_forward_ios,color: Colors.black,),
                                    ),
                                  ],
                                ),
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
