import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/userModel.dart';
import '../../utils/fonts.dart';
import '../../widgets/buttons.dart';
import '../../widgets/my_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MechanicProfileScreen extends StatefulWidget {
  MechanicProfileScreen();


  @override
  MechanicProfileScreenState createState() => new MechanicProfileScreenState();
}

class MechanicProfileScreenState extends State<MechanicProfileScreen> {
  String url = "";
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getImg('s');
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapMechanicRegistration(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    getImg(loggedInUser.profileImageReference.toString());
    final updateProfileButton =
        PrimaryButton.primaryButton(context, "Update Profile", onPressed: () {
      Navigator.pushNamed(context, '/updateMechanicProfile');
    });
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.yellow,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 1,
                  color: primaryColor,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  transform: Matrix4.translationValues(0, 50, 0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(height: 70),
                Container(height: 15),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },

                ),
                Text("${loggedInUser.fullName}",
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.bold)),
                Container(height: 15),
                Text("${loggedInUser.email}",
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.bold)),
                Container(height: 25),
                Text("${loggedInUser.cnic}",
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.bold)),
                Container(height: 25),
                Text("${loggedInUser.city}",
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.bold)),
                Container(height: 25),
                Text("${loggedInUser.mobileNumber}",
                    style: MyText.headline(context)!.copyWith(
                        color: Colors.grey[900], fontWeight: FontWeight.bold)),
                Container(height: 35),
                Divider(height: 50),
                Container(height: 35),
                updateProfileButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('profileImages/')
        .child(s);
    url = await ref.getDownloadURL();
  }
}
