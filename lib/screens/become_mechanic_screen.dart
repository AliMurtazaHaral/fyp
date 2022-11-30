
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/userModel.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';

class BecomeMechanicScreen extends StatefulWidget {
  const BecomeMechanicScreen({Key? key}) : super(key: key);

  @override
  State<BecomeMechanicScreen> createState() => _BecomeMechanicScreenState();
}

class _BecomeMechanicScreenState extends State<BecomeMechanicScreen>
    with TickerProviderStateMixin {
  final phoneNumberEditingController = TextEditingController();
  final cityEditingController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("phone number field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        phoneNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Mobile number",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final cityField = TextFormField(
      autofocus: false,
      controller: cityEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("phone number field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        cityEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter City",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final becomeMechanicButton = PrimaryButton.primaryButton(
        context, "Become a Mechanic", onPressed: () {
      postDetailsToFirestore();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Become a Mechanic',
            style: TextStyle(color: secondaryColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              RotationTransition(
                turns: controller,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              phoneNumberField,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              cityField,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              becomeMechanicButton
            ],
          ),
        ),
      ),
    );
  }

  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all the values
    userModel.profession = "Mechanic";
    userModel.city = cityEditingController.text;
    userModel.mobileNumber = phoneNumberEditingController.text;
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toBecomeMechanicRegistration());
    Navigator.pushNamed(context, "/mechanicDashboard");
  }
}
