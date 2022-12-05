import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/face_recognition_for_mechanic_screen.dart';

import '../../models/userModel.dart';
import '../../utils/fonts.dart';
import '../../widgets/buttons.dart';

class MechanicCategoryRegistrationScreen extends StatefulWidget {
  MechanicCategoryRegistrationScreen({Key? key,required this.fullName, required this.email, required this.phoneNumber, required this.cnic, required this.password,required this.city,required this.uploadImage}) : super(key: key);
  String? fullName;
  String? email;
  String? phoneNumber;
  String? password;
  String? cnic;
  String? city;
  String? uploadImage;
  @override
  State<MechanicCategoryRegistrationScreen> createState() => _MechanicCategoryRegistrationScreenState();
}

class _MechanicCategoryRegistrationScreenState extends State<MechanicCategoryRegistrationScreen> {
  String category = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.1),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(7, 7), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              //1
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, defaultPadding, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/diesel-mechanic.jpg",
                        "Diesel Engine Mechanic", onTap: () {
                      category = "Diesel Engine Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/break-transmission-technician.jpg",
                        "Breaks and Transmission Technician", onTap: () {
                      category = "Breaks and Transmission Technician";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //2
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/break-transmission-technician.jpg",
                        "Dentar and Painter", onTap: () {
                      category = "Dentar and Painter";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/autobody-mechanic.jpg",
                        "Tire Puncture", onTap: () {
                      category = "Tire Puncture";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //3
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/motorcycle-mechanic.jpg",
                        "Motorcycle Mechanic", onTap: () {
                      category = "Motorcycle Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/service-mechanic.jpg",
                        "AC Repairer", onTap: () {
                      category = "AC Repairer";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //4
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, defaultPadding, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/auto-glass-mechanic.png",
                        "Petrol Engine Mechanic", onTap: () {
                      category = "Petrol Engine Mechanic";
                      postDetailsToFirestore();
                    },
                    ),
                  ],
                ),
              ),
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
   userModel.category = category;
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMechanicCategoryRegistration());
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MechanicFaceDetectionScreen(fullName: widget.fullName, cnic: widget.cnic, email: widget.email, password: widget.password, profession: 'Mechanic', profileImageReference: widget.uploadImage)));
  }
}
