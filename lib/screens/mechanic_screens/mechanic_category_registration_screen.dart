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
                        "Diesel Mechanic", onTap: () {
                      category = "Diesel Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/general-automotive-mechanic.jpg",
                        "General Automotive Mechanic", onTap: () {
                      category = "General Automotive Mechanic";
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
                        "Break and Transmission Technician", onTap: () {
                      category = "Break and Transmission Technician";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/autobody-mechanic.jpg",
                        "AutoBody Mechanic", onTap: () {
                      category = "AutoBody Mechanic";
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
                        "assets/images/race-car-mechanic.jpg",
                        "Race Car Mechanic", onTap: () {
                      category = "Race Car Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/service-mechanic.jpg",
                        "Service Technicians", onTap: () {
                      category = "Service Technician";
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
                        "Auto Glass Mechanic", onTap: () {
                      category = "Auto Glass Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/heavy-equipment-mechanic.jpg",
                        "Heavy Equipment Mechanic", onTap: () {
                      category = "Heavy Equipment Mechanic";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //5
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/air-craft-mechanic.jpg",
                        "Air Craft Mechanic", onTap: () {
                      category = "Air Craft Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/small-engine-mechanic.jpg",
                        "Small Engine Mechanic", onTap: () {
                      category = "Small Engine Mechanic";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //6
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/marine-mechanic.jpg",
                        "Marine Mechanic", onTap: () {
                      category = "Marine Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/tire-mechanic.jpg",
                        "Tire Mechanic", onTap: () {
                      category = "Tire Mechanic";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //7
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, defaultPadding, defaultPadding, 0),
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
                        "assets/images/boat-mechanic.jpg",
                        "Boat Mechanic", onTap: () {
                      category = "Boat Mechanic";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //8
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/bicycle-mechanic.jpg",
                        "Bicycle Mechanic", onTap: () {
                      category = "Bicycle Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/air-conditioning-mechanic.jpg",
                        "Air Conditioning Mechanic", onTap: () {
                      category = "Air Conditioning Mechanic";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //9
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/plumbing-mechanic.jpg",
                        "Plumbing Mechanic", onTap: () {
                      category = "Plumbing Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/line-mechanic.jpg",
                        "Line Mechanic", onTap: () {
                      category = "Line Mechanic";
                      postDetailsToFirestore();
                    }),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //10
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/auto-exhuast-mechanic.jpg",
                        "Auto Exhaust Mechanic", onTap: () {
                      category = "Auto Exhaust Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/aftermarket-mechanic.jpg",
                        "Aftermarket Mechanic", onTap: () {
                      category = "Aftermarket Mechanic";
                      postDetailsToFirestore();
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //11
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/roadside-assistance-mechanic.png",
                        "Roadside Assistance Mechanic", onTap: () {
                      category = "Roadside Assistance Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/welding-mechanic.jpg",
                        "Welding Mechanic", onTap: () {
                      category = "Welding Mechanic";
                      postDetailsToFirestore();
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //12
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/motocycle-engine-mechanic.jpg",
                        "Motorcycle Engine Mechanic", onTap: () {
                      category = "Motorcycle Engine Mechanic";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/motorcycle-technician-mechanic.jpg",
                        "Motorcycle Technician", onTap: () {
                      category = "Motorcycle Technician";
                      postDetailsToFirestore();
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //13
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/motorcycle-service-technician-mechanic.jpg",
                        "Motorcycle Service Technician", onTap: () {
                      category = "Motorcycle Service Technician";
                      postDetailsToFirestore();
                    }),
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/carburetor-mechanic.jpg",
                        "Carburetor Mechanic", onTap: () {
                      category = "Carburetor Mechanic";
                      postDetailsToFirestore();
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              //14
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton.categoryButton(
                        context,
                        "assets/images/heavy-bike-mechanic.jpg",
                        "Heavy Bike Mechanic", onTap: () {
                      category = "Heavy Bike Mechanic";
                      postDetailsToFirestore();
                    }),
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
