import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/map_screens/map_utils.dart';
import 'package:fyp/screens/mechanic_screens/drawer/navigation_drawer_screen.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/utils/fonts.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../models/userModel.dart';
import '../chat/views/conversationScreen.dart';

class MechanicEarningScreen extends StatefulWidget {
  const MechanicEarningScreen({Key? key}) : super(key: key);

  @override
  State<MechanicEarningScreen> createState() => _MechanicEarningScreenState();
}

class _MechanicEarningScreenState extends State<MechanicEarningScreen> {
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
                height: MediaQuery.of(context).size.height * .30,
                decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0))),
                child: Center(
                  child: Text(
                    "Total Earning",
                    style: TextStyle(
                        color: secondaryColor,
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
                                  streamSnapshot.data!.docs[index]["status"]=='Completed'?
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
                                              color: Colors.grey,
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
                                                Image(
                                                  image: AssetImage(
                                                      "assets/images/map.jpg"),
                                                  height: 220,
                                                  width: double.infinity,
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
                                                GestureDetector(
                                                  onTap: () {
                                                    createChatRoomAndStartConversation(
                                                        streamSnapshot
                                                            .data
                                                            ?.docs[index]
                                                        [
                                                        'customerName'],
                                                        loggedInUser
                                                            .fullName
                                                            .toString());
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
                                                        'Message',
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
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            .2,
                                      ),
                                    ],
                                  ): Text("",style: TextStyle(fontSize: 0),),
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
            chatRoomId: chatRoomId, myName: myName, userName: userName, currentU: user!.uid,),
      ),
    );
  }
}
