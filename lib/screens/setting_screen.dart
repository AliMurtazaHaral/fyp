
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/mechanic_screens/mechanic_help_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/userModel.dart';
import '../utils/fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final collectionRefernce = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance.currentUser;
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
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        color: secondaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                defaultPadding, 25, defaultPadding, defaultPadding),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.height * 0.92,
                  decoration: const BoxDecoration(
                    color: Color(0xFF161616),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(defaultPadding),
                      topRight: Radius.circular(defaultPadding),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.yellow,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  width: 20,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'General',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                buildAccount(
                  context,
                  "Account",
                ),
                const SizedBox(
                  height: 20,
                ),
                buildNotifications(
                  context,
                  "Notifications",
                ),
                const SizedBox(
                  height: 20,
                ),
                buildMembership(
                  context,
                  "Membership",
                ),
                const SizedBox(
                  height: 20,
                ),
                buildDeleteAccount(
                  context,
                  "Delete Account",
                ),
                const SizedBox(
                  height: 20,
                ),
                buildLogout(
                  context,
                  "Logout",
                ),
                const SizedBox(
                  height: 20,
                ),

                Divider(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                buildHelp(
                  context,
                  "Help",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildAccount(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildDeleteAccount(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        deleteUserAccount(
            loggedInUser.email.toString(), loggedInUser.password.toString());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildNotifications(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/paymentJazzCash');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildMembership(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildHelp(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildLogout(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        logout(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/',
        arguments: (Route<dynamic> route) => false);
  }

  Future<void> deleteUserAccount(String email, String pass) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);
    await _auth!.reauthenticateWithCredential(credential).then((value) {
      value.user!.delete().then((res) {
        collectionRefernce.doc(loggedInUser.uid.toString()).delete().then(
              (value) =>
                  Fluttertoast.showToast(msg: "Account Deleted Successfully"),
            );
        Navigator.pushNamed(context, '/');
      });
    }).catchError((onError) => Get.snackbar("Credential Error", "Failed"));
  }
}
