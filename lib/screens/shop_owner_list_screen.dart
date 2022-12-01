import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/product_screen.dart';
import 'package:nice_buttons/nice_buttons.dart';
import '../models/userModel.dart';
import '../services/database.dart';
import '../utils/fonts.dart';

class ShopOwnerListScreen extends StatefulWidget {
  const ShopOwnerListScreen({Key? key}) : super(key: key);

  @override
  State<ShopOwnerListScreen> createState() => _ShopOwnerListScreenState();
}

class _ShopOwnerListScreenState extends State<ShopOwnerListScreen> {
  String url = "";
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('products').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('products').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();



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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(''),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.1,
                decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0))),
                child: Center(
                  child: Text(
                    "Spare Parts",style: TextStyle(color: secondaryColor,fontSize: 30,fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.1,
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
                            List<Widget> Data = [];
                            var image_2;
                            final product = streamSnapshot.data?.docs;
                            return product?.length != 0
                                ? SingleChildScrollView(
                                  child: Column(children: [
                              for (var data in product!)

                                  FutureBuilder<String>(
                                      future: getImg(data["productImage"]),
                                      builder: (_, imageSnapshot) {
                                        final imageUrl = imageSnapshot.data;
                                        return imageUrl != null
                                            ? Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                                              width: MediaQuery.of(context).size.width*.9,
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
                                                    color: Color(0xFFFAC213),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(shopName:data['shopName'])));
                                                },
                                                child: Padding(
                                                    padding: EdgeInsets.only(left: 0,right: 0),
                                                    child: Row(

                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: primaryColor),
                                                            borderRadius: BorderRadius.circular(1.0),
                                                          ),
                                                          child: Image(image: NetworkImage(imageUrl),
                                                            height: MediaQuery.of(context).size.height*.15,
                                                            width: MediaQuery.of(context).size.width*.25,),
                                                        ),

                                                        Padding(
                                                          padding: EdgeInsets.only(left: 20),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                  padding:EdgeInsets.only(bottom: 5),
                                                                  child: Text("${data['productName']}",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                                                              Padding(
                                                                padding: EdgeInsets.only(bottom: 5),
                                                                child: Row(
                                                                  children: [
                                                                    Text("${data['shopName']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                                                    Text(" | 5 star Rating",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text("Price: ${data['productPrice']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                                                            ],
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height*.02,
                                                        ),
                                                      ],
                                                    )
                                                ),
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
                                              height: 10,
                                            ),
                                          ],
                                        )
                                            : const SizedBox();
                                      })
                            ]),
                                )
                                : SizedBox(height: 1000,);
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
        .ref('productImages/')
        .child(s);
    url = await ref.getDownloadURL();
    return await ref.getDownloadURL();
  }
}