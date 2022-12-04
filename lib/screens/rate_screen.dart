import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/userModel.dart';
import '../widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RateScreen extends StatefulWidget {
  RateScreen({Key? key,required this.uniId}) : super(key: key);
  String? uniId;
  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String? rate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.20,),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo_completed.jpeg",
                    height: 200,
                    width: 200,
                  )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Rate Mechanic!',
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState((){
                  rate = rating.toString();
                });
                print(rating);
              },

            ),
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              child: MaterialButton(

                padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  postDetailsToFirestore();
                  Navigator.pushNamed(context, '/mechanicList');
                },
                child: Text(
                  'Rate Him',
                  textAlign: TextAlign.center,
                  style: const TextStyle(

                      color: Colors.white,
                      fontWeight: FontWeight.normal),

                ),),
            ),
          ],
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
    userModel.rating = rate;
    await firebaseFirestore
        .collection("users")
        .doc(widget.uniId)
        .update(userModel.toMechanicRating());
  }
}
