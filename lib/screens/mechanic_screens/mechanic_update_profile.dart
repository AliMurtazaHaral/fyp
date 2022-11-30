
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/storage_model.dart';
import '../../models/userModel.dart';
import '../../utils/fonts.dart';
import '../../widgets/buttons.dart';
import '../../widgets/logo.dart';

class UpdateMechanicProfileScreen extends StatefulWidget {
  const UpdateMechanicProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateMechanicProfileScreen> createState() =>
      _UpdateMechanicProfileScreenState();
}

class _UpdateMechanicProfileScreenState
    extends State<UpdateMechanicProfileScreen> with TickerProviderStateMixin {
  final fullNameEditingController = TextEditingController();
  final cnicEditingController = TextEditingController();
  final cityEditingController = TextEditingController();
  final mobileNumberEditingController = TextEditingController();
  final uploadEditingController = TextEditingController();
  final StorageModel storage = StorageModel();
  late Reference getUrl;
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
    //full name field
    final fullNameField = TextFormField(
      autofocus: false,
      controller: fullNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        fullNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
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
          return ("Name cannot be Empty");
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
    final mobileNumberField = TextFormField(
      autofocus: false,
      controller: mobileNumberEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        mobileNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Mobile Number",
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
    //full name field
    final cnicField = TextFormField(
      autofocus: false,
      controller: cnicEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter cnic here");
        }
        return null;
      },
      onSaved: (value) {
        cnicEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "xxxxx-xxxxxxx-x",
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
    //image picker
    final dottedBoder = DottedBorder(
      color: Colors.grey,
      strokeWidth: 2,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Material(
          elevation: 5,
          //borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width * 0.93,
            height: 100,
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png'],
              );
              if (result == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('no file selected'),
                  ),
                );
              } else {
                final path = result?.files.single.path;
                final fileName = result?.files.single.name;
                storage
                    .uploadFileImage(path, fileName)
                    .then((value) => const SnackBar(
                          content: Text("FIle Has been uploaded successfully"),
                        ));
                getUrl = FirebaseStorage.instance.ref().child(fileName!);
              }
            },
            child: const Text(
              "Upload Image",
              style:
                  TextStyle(color: buttontextColor, fontSize: buttonTextSize),
            ),
          ),
        ),
      ),
    );
    //signup button
    final updateProfileButton =
        PrimaryButton.primaryButton(context, "Update Profile", onPressed: () {
      updateProfile();
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: secondaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(centralPadding)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Update Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: appBarSize,
                            color: textColor),
                      ),
                    ),
                    logoRemainingPage(context, controller),
                    fullNameField,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    cnicField,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    mobileNumberField,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    cityField,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    dottedBoder,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    updateProfileButton,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                  ],
                ),
              ),
            ),
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
    userModel.uid = user!.uid;
    userModel.cnic = cnicEditingController.text;
    userModel.city = cityEditingController.text;
    userModel.mobileNumber = mobileNumberEditingController.text;
    userModel.fullName = fullNameEditingController.text;
    userModel.profileImageReference = getUrl.fullPath.toString();
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMapUpdateMechanicRegistration());
    Navigator.pushNamed(context, "/mechanicDashboard");
  }

  updateProfile() {
    postDetailsToFirestore();
  }
}
