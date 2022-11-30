import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/book_mechanic_model.dart';
import 'package:fyp/utils/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingDetailScreen extends StatefulWidget {
  BookingDetailScreen({Key? key,required this.mechanicName, required this.customerName,required this.status, required this.address,required this.id}) : super(key: key);
  String? customerName;
  String? mechanicName;
  String? address;
  String? status;
  String? id;
  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor, brightness: Brightness.dark,
        title: Text("Booked Mechanic"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {Navigator.pop(context);},
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[

                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Your Name: ${widget.mechanicName}", style: TextStyle(color: primaryColor)),
                            Container(height: 2),
                            Text("Booked", style: TextStyle(color: primaryColor))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.info, color: primaryColor), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text("Reach as soon as possible", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),textAlign: TextAlign.left,),
                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.sync, color: primaryColor), width: 50),
                        Container(width: 15),
                        Text("Runing short of time", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),

                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Order Status", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.payments, color: primaryColor), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () async{
                                print('Text Clicked');
                                Fluttertoast.showToast(msg: "Congrats... You just have completed an order.");
                                final _auth = FirebaseAuth.instance;
                                FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                                User? user = _auth.currentUser;
                                BookMechanicModel userModel = BookMechanicModel();

                                // writing all the values
                                userModel.status = 'Completed';
                                await firebaseFirestore
                                    .collection("book_mechanic")
                                    .doc(widget.id)
                                    .update(userModel.toUpdateStatus());

                                Navigator.pop(context);
                              },
                              child: Text("Complete", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
                            ),

                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.smart_button, color: primaryColor), width: 50),
                        Container(width: 15),
                        InkWell(
                            onTap: () async{

                              await FirebaseFirestore.instance.collection('book_mechanic').doc(widget.id).delete();
                              Navigator.pop(context);

                            },
                            child: Text("Cancel", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Your Information", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.person, color: primaryColor), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name: ${widget.customerName}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.location_on, color: primaryColor), width: 50),
                        Container(width: 15),
                        Expanded(
                          child: Text("${widget.address}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }
}
