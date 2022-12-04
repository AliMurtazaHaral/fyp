import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/product_screen.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/userModel.dart';
import '../services/database.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';
import 'chat/views/conversationScreen.dart';

class TopRatedShopScreen extends StatefulWidget {
  const TopRatedShopScreen({Key? key}) : super(key: key);

  @override
  State<TopRatedShopScreen> createState() => _TopRatedShopScreenState();
}

class _TopRatedShopScreenState extends State<TopRatedShopScreen> {
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
  int i = 0;
  @override
  Widget build(BuildContext context) {
    getImg("s");
    return Scaffold(
      appBar: AppBar(
          actions: [],
          backgroundColor: primaryColor,
          title: const Text("Top Rated Shops"),
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
                        padding: const EdgeInsets.all(20),
                        child: Expanded(
                          child: streamSnapshot.data?.docs.length != 0
                              ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data?.docs.length,
                            itemBuilder: (ctx, index) => streamSnapshot
                                .data?.docs[index]['profession']
                                .toString() ==
                                'Vendor' && streamSnapshot
                                .data?.docs[index]['rating']
                                .toString() ==
                                '5'
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
                                          Text("${getImg(streamSnapshot.data?.docs[index]['shopImageReference']).toString()}",style: TextStyle(fontSize: 0),),
                                          Image(image: NetworkImage(url)),

                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*.02,
                                          ),
                                          Text("${streamSnapshot.data?.docs[index]['shopName']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*.02,
                                          ),
                                          NiceButtons(
                                            stretch: false,
                                            startColor: primaryColor,
                                            borderRadius: 30,
                                            borderColor: primaryColor,
                                            endColor: primaryColor,
                                            gradientOrientation: GradientOrientation.Horizontal,
                                            onTap: (finish)=> {
                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(shopName:streamSnapshot.data?.docs[index]['shopName']))),
                                            },
                                            child: Text(
                                              'Explore',
                                              style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height*.02,
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
          .where('category'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      foundMechanic = results;
    });
  }
}
