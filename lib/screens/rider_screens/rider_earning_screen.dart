import 'dart:async';

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

class RiderEarningScreen extends StatefulWidget {
  const RiderEarningScreen({Key? key}) : super(key: key);

  @override
  State<RiderEarningScreen> createState() => _RiderEarningScreenState();
}

class _RiderEarningScreenState extends State<RiderEarningScreen> with TickerProviderStateMixin{
  String url = "";
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('shoped_products').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('shoped_products').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  bool expand = false;
  late AnimationController controller;
  late Animation<double> animation, animationView;
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
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);

    animation = Tween(begin: 0.0, end: -0.5).animate(controller);
    animationView = CurvedAnimation(parent: controller, curve: Curves.linear);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), (){
        togglePanel();
      });
    });
  }
  void togglePanel(){
    if(!expand){
      controller.forward(from:0);
    } else {
      controller.reverse();
    }
    expand = !expand;
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
                    "Total Earning:5000",
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
                                  streamSnapshot.data!.docs[index]
                                  ["riderName"] ==
                                      loggedInUser.fullName
                                      ? Column(
                                    children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    createChatRoomAndStartConversation(
                                                        streamSnapshot
                                                            .data?.docs[index]
                                                        ['fullName'],
                                                        loggedInUser.fullName
                                                            .toString());
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 16.0),
                                                    child: const Text('Message',
                                                        style: TextStyle(
                                                            color: Colors.white)),
                                                  ),
                                                ),
                                                Text("${streamSnapshot.data?.docs[index]['status']}",textAlign: TextAlign.center,style: TextStyle(
                                                    color: primaryColor,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[

                                                      Container(width: 15),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text("${streamSnapshot.data?.docs[index]["productName"]}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                            Container(height: 2),
                                                            Text("", style: TextStyle(color: primaryColor)),
                                                          ],
                                                        ),
                                                      ),
                                                      RotationTransition(
                                                        turns: animation,
                                                        child: IconButton(
                                                          icon: Icon(Icons.expand_less),
                                                          onPressed: (){
                                                            togglePanel();
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizeTransition(
                                                    sizeFactor: animationView,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(height: 25),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(child: Icon(Icons.location_on, color: primaryColor, size: 30), width: 50),
                                                            Container(width: 15),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text("Pickup Place: ", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                                Container(height: 2),
                                                                Text("${streamSnapshot.data?.docs[index]["pickupPoint"]}", style: TextStyle(color: primaryColor))
                                                              ],
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        Container(height: 20),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(child: Icon(Icons.location_on, color: primaryColor, size: 30), width: 50),
                                                            Container(width: 15),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text("Delivery Location", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                                Container(height: 2),
                                                                Text("${streamSnapshot.data?.docs[index]["deliveryPoint"]}", style: TextStyle(color: primaryColor))
                                                              ],
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        Container(height: 20),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(child: Icon(Icons.location_on, color: secondaryColor, size: 30), width: 50),
                                                            Container(width: 15),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text("Change Status", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                                Container(height: 2),
                                                                InkWell(
                                                                  onTap: () async{
                                                                    print('Text Clicked');
                                                                    final _auth = FirebaseAuth.instance;
                                                                    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                                                    User? user = _auth.currentUser;
                                                                    ShopedProductModel userModel = ShopedProductModel();

                                                                    // writing all the values
                                                                    userModel.status = 'Completed';
                                                                    await firebaseFirestore
                                                                        .collection("shoped_mechanic")
                                                                        .doc("zdKssrREY0Wb3zfuNkeT")
                                                                        .update(userModel.toMapShopedProductOrderComplete());

                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Text("Complete", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        Container(height: 20),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(child: Icon(Icons.location_on, color: secondaryColor, size: 30), width: 50),
                                                            Container(width: 15),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text("Change Status", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                                Container(height: 2),
                                                                InkWell(
                                                                  onTap: () async{
                                                                    print('Text Clicked');
                                                                    final _auth = FirebaseAuth.instance;
                                                                    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                                                    User? user = _auth.currentUser;
                                                                    ShopedProductModel userModel = ShopedProductModel();

                                                                    // writing all the values
                                                                    userModel.status = 'Cancelled';
                                                                    await firebaseFirestore
                                                                        .collection("shoped_mechanic")
                                                                        .doc("zdKssrREY0Wb3zfuNkeT")
                                                                        .update(userModel.toMapShopedProductOrderComplete());

                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Text("Cancel", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        Container(height: 10),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(height: 5)
                                          ],
                                        ),
                                      ),
                                      Container(height: 10),
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
}
