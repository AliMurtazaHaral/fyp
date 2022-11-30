import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fyp/models/product_model.dart';

import '../models/userModel.dart';
import '../services/database.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';
import 'chat/views/conversationScreen.dart';

class TopRatedProductScreen extends StatefulWidget {
  const TopRatedProductScreen({Key? key}) : super(key: key);

  @override
  State<TopRatedProductScreen> createState() => _TopRatedProductScreenState();
}

class _TopRatedProductScreenState extends State<TopRatedProductScreen> with TickerProviderStateMixin{
  bool expand = false;
  late AnimationController controller;
  late Animation<double> animation, animationView;

  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('products').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('products').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }



  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {

    super.initState();
    getImg("shop.jpg");
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
      appBar: AppBar(
          actions: [],
          backgroundColor: primaryColor,
          title: const Text("Top Products"),
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
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Expanded(
                          child: streamSnapshot.data?.docs.length != 0
                              ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data?.docs.length,
                            itemBuilder: (ctx, index) => streamSnapshot
                                .data?.docs[index]['productRating']
                                .toString() ==
                                '5'
                                ? Column(
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("${getImg(streamSnapshot.data?.docs[index]['productImage']).toString()}",style: TextStyle(
                                          color: secondaryColor,fontWeight: FontWeight.bold),),

                                      Image(image: NetworkImage(url),
                                        height: 220, width: double.infinity, fit: BoxFit.cover,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(radius: 25,
                                                  backgroundImage: NetworkImage(url),
                                                ),
                                                Container(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text("${streamSnapshot.data?.docs[index]["productName"]}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                      Container(height: 2),
                                                      Text("${streamSnapshot.data?.docs[index]["productRating"]}", style: TextStyle(color: primaryColor)),
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
                                                      Container(child: Icon(Icons.price_change, color: primaryColor, size: 30), width: 50),
                                                      Container(width: 15),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text("Price: ", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                          Container(height: 2),
                                                          Text("${streamSnapshot.data?.docs[index]["productPrice"]}", style: TextStyle(color: primaryColor))
                                                        ],
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                  Container(height: 20),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(child: Icon(Icons.price_change_outlined, color: primaryColor, size: 30), width: 50),
                                                      Container(width: 15),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text("Quantity", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                          Container(height: 2),
                                                          Text("${streamSnapshot.data?.docs[index]["productQuantity"]}", style: TextStyle(color: primaryColor))
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
      ),
    );
  }
  String url = '';
  getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('productImages/')
        .child(s);
    url = await ref.getDownloadURL();
    return await ref.getDownloadURL();
  }
  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
    FirebaseFirestore.instance.collection('products').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allMechanic;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('products')
          .where('productName'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();

    }

    // Refresh the UI
    setState(() {
      foundMechanic = results;
    });
  }
}