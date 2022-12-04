import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/shoped_products.dart';
import 'package:fyp/screens/loading_screen.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/userModel.dart';
import '../services/database.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';
import 'chat/views/conversationScreen.dart';
import 'faq_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.shopName,required this.productImage}) : super(key: key);
  String? shopName;
  String? productImage;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin{
  bool expand = false;
  late AnimationController controller;
  late Animation<double> animation, animationView;

  String url = "";
  final Stream<QuerySnapshot<Map<String, dynamic>>> allMechanic =
  FirebaseFirestore.instance.collection('products').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundMechanic =
  FirebaseFirestore.instance.collection('products').snapshots();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool flag = true;


  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getImg("s");
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);

    animation = Tween(begin: 0.0, end: -0.5).animate(controller);
    animationView = CurvedAnimation(parent: controller, curve: Curves.linear);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), (){
        togglePanel();
      });
    });
  }
  void togglePanel(){
    if(!expand){
      controller.forward(from:0);
    } else {
      controller.reverse();
    }
    expand = !expand;
  }
  int i = 0;
  @override
  Widget build(BuildContext context) {
    getImg("s");
    return flag==false?LoadingScreen():Scaffold(
      appBar: AppBar(
          actions: [],
          backgroundColor: primaryColor,
          title: const Text("Products"),
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
                                .data?.docs[index]['shopName']
                                .toString() ==

                                widget.shopName
                                ? Column(
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[


                                      Image(image: NetworkImage('${widget.productImage}'),
                                        height: 220, width: double.infinity, fit: BoxFit.cover,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(radius: 25,
                                                  backgroundImage: NetworkImage('${widget.productImage}'),
                                                ),
                                                Container(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text("${streamSnapshot.data?.docs[index]["productName"]}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                      Container(height: 2),
                                                      Text("${streamSnapshot.data?.docs[index]["productRating"]}", style: TextStyle(color: primaryColor)),
                                                    ],
                                                  ),
                                                ),
                                                RotationTransition(
                                                  turns: animation,
                                                  child: IconButton(
                                                    icon: Icon(Icons.expand_less),
                                                    onPressed: (){
                                                      togglePanel();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizeTransition(
                                              sizeFactor: animationView,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(height: 25),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(child: Icon(Icons.price_change, color: primaryColor, size: 30), width: 50),
                                                      Container(width: 15),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text("Price: ", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                          Container(height: 2),
                                                          Text("${streamSnapshot.data?.docs[index]["productPrice"]}", style: TextStyle(color: primaryColor))
                                                        ],
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                  Container(height: 20),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(child: Icon(Icons.price_change_outlined, color: primaryColor, size: 30), width: 50),
                                                      Container(width: 15),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text("Quantity", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                                                          Container(height: 2),
                                                          Text("${streamSnapshot.data?.docs[index]["productQuantity"]}", style: TextStyle(color: primaryColor))
                                                        ],
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                  Container(height: 10),
                                                ],
                                              ),
                                            ),
                                            Accordion(
                                              title: 'Description',
                                              content:
                                              "${streamSnapshot.data?.docs[index]["productDescription"]}",
                                            ),

                                          ],
                                        ),
                                      ),

                                      Container(height: 5),
                                      Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black,
                                        child: MaterialButton(

                                          padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                                          minWidth: MediaQuery.of(context).size.width * 0.8,
                                          onPressed: () async{
                                            Fluttertoast
                                                .showToast(
                                                msg: "Mechanic has been booked successfully");
                                            setState((){
                                              flag = false;
                                            });
                                            p = await _determinePosition();
                                            Fluttertoast
                                                .showToast(
                                                msg: "Mechanic has been booked successfully");
                                            List<Placemark>
                                            placemarks =
                                                await placemarkFromCoordinates(p.latitude, p.longitude);
                                            print(placemarks);
                                            Placemark place = placemarks[0];
                                            final Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                            postDetailsToFirestore(
                                                streamSnapshot.data?.docs[index]
                                                [
                                                'productName'],
                                                streamSnapshot.data?.docs[index]
                                                [
                                                'productPrice'],
                                                streamSnapshot.data?.docs[index]
                                                [
                                                'address'],
                                                Address
                                            );

                                          },
                                          child: const Text(
                                            'Buy Now',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(

                                                color: Colors.yellow,
                                                fontWeight: FontWeight.normal),

                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 10),

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
    FirebaseFirestore.instance.collection('products').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allMechanic;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('products')
          .where('productName'.toString(), isEqualTo: enteredKeyword.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      foundMechanic = results;
    });
  }
  late Position p;
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  postDetailsToFirestore(String name,String price,String shopAddress,String deliveryAddress) async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    ShopedProductModel userModel = ShopedProductModel();

    // writing all the values
    userModel.pickupPoint = shopAddress;
    userModel.deliveryPoint = deliveryAddress;
    userModel.status = 'Pending';
    userModel.productPrice = price;
    userModel.productName = name;
    await firebaseFirestore
        .collection("shoped_products")
        .doc()
        .set(userModel.toMapShopedProduct());
    setState(() {
      flag = true;
    });
    Fluttertoast
        .showToast(
        msg: "Mechanic has been booked successfully");
    goToMain();
  }
  goToMain(){
    Navigator.pushNamed(context, '/dashboard');
  }
}
