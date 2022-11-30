
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/payment_methods/jazzcash_payment.dart';

import '../models/userModel.dart';
import '../utils/fonts.dart';

class PaymentSceen extends StatefulWidget {
  const PaymentSceen({Key? key}) : super(key: key);

  @override
  State<PaymentSceen> createState() => _PaymentSceenState();
}

class _PaymentSceenState extends State<PaymentSceen> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('users').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('users').snapshots();

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
        backgroundColor: primaryColor,
        title: const Text("All Mechanics"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1,
          color: secondaryColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 400,
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
                              'Mechanic'
                              ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                    Colors.brown.shade800,
                                    child: Icon(Icons.person),
                                  ),
                                  Text(
                                    "${streamSnapshot.data?.docs[index]['fullName']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (payment()) {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Has been Successfuly Paid");
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                            "Payment Failed due to some Reason");
                                      }
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
                                      child: const Text('Pay',
                                          style: TextStyle(
                                              color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                              : const Text(
                            '',
                            style: TextStyle(fontSize: 24),
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
    );
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
          .where('fullName'.toString(), isEqualTo: '$enteredKeyword'.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      foundMechanic = results;
    });
  }
}