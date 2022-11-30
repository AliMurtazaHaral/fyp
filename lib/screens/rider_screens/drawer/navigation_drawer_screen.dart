
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fyp/screens/rider_screens/rider_indox_screen.dart';
import '../../../models/userModel.dart';
import 'drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;
  String url = "";
  void getData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(context),
              const SizedBox(height: 40,),
              const Divider(thickness: 1, height: 10, color: Colors.grey,),
              const SizedBox(height: 40,),
              DrawerItem(
                name: 'People',
                icon: Icons.people,
                onPressed: ()=> onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'My Account',
                  icon: Icons.account_box_rounded,
                  onPressed: (){
                    Navigator.pushNamed(context, '/profile');
                  }
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Chats',
                  icon: Icons.message_outlined,
                  onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>RiderInboxScreen()))
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Favourites',
                  icon: Icons.favorite_outline,
                  onPressed: ()=> onItemPressed(context, index: 3)
              ),
              const SizedBox(height: 30,),
              const Divider(thickness: 1, height: 10, color: Colors.grey,),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Setting',
                  icon: Icons.settings,
                  onPressed: (){
                    Navigator.pushNamed(context, '/riderSetting');
                  }
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: ()async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/',
                  arguments: (Route<dynamic> route) => false);
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 4:
        Navigator.pushNamed(context, "/riderSetting");
        break;
    }
  }

  Widget headerWidget(BuildContext context) {
    getData();
    getImg(loggedInUser.profileImageReference.toString());

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loggedInUser.fullName.toString(), style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(height: 10,),
            SizedBox(width: MediaQuery.of(context).size.width*0.4,
              child: Text(loggedInUser.email.toString(), maxLines: 2,
                  softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.white)),
            ),

          ],
        )
      ],
    );

  }
  getImg(String s) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('profileImages/')
        .child(s);
    url = await ref.getDownloadURL();
  }
}


