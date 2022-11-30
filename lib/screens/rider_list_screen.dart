import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/utils/fonts.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../models/userModel.dart';

class RiderListScreen extends StatefulWidget {
  const RiderListScreen({Key? key}) : super(key: key);

  @override
  State<RiderListScreen> createState() => _RiderListScreenState();
}

class _RiderListScreenState extends State<RiderListScreen> {
  String url = "";
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('users').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('users').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();



  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getImg('profile.jpeg');
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
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.30,
                decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0))),
                child: Center(
                  child: Text(
                    "Riders",style: TextStyle(color: secondaryColor,fontSize: 30,fontStyle: FontStyle.italic),
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
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Expanded(
                                child: streamSnapshot.data?.docs.length != 0
                                    ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: streamSnapshot.data?.docs.length,
                                  itemBuilder: (ctx, index) => streamSnapshot
                                      .data?.docs[index]['profession']
                                      .toString() ==
                                      'Rider'
                                      ? Column(
                                    children: [

                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 10,right: 10),
                                            child: Column(

                                              children: [
                                                Text(getImg(streamSnapshot.data?.docs[index]['profileImageReference']).toString(),style: TextStyle(fontSize: 0),),
                                                Image(image: NetworkImage(url),width: MediaQuery.of(context).size.width*1,),

                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height*.02,
                                                ),
                                                Text("${streamSnapshot.data?.docs[index]['fullName']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height*.1,
                                                ),
                                              ],
                                            )
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height*.2,
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
          )
      ),
    );
  }
  Future<String> getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('profileImages/')
        .child(s);
    url = await ref.getDownloadURL();
    return await ref.getDownloadURL();
  }
}
