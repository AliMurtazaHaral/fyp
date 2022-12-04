import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/screens/loading_screen.dart';
import 'package:fyp/utils/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/parser.dart' as parser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/userModel.dart';
import '../widgets/buttons.dart';
class CustomerFaceDetectionScreen extends StatefulWidget {
  String? email;
  String? password;
  String? fullName;
  String? profession;
  String? cnic;
  String? profileImageReference;
  CustomerFaceDetectionScreen({super.key, required this.fullName,required this.cnic, required this.email, required this.password, required this.profession, required this.profileImageReference});

  @override
  CustomerFaceDetectionScreenState createState() => new CustomerFaceDetectionScreenState();
}

class CustomerFaceDetectionScreenState extends State<CustomerFaceDetectionScreen> {
  bool flag = true;
  File? selectedImage;
  File? second_Image;
  String? message = "";
  String? bg_image = "";
  User? user = FirebaseAuth.instance.currentUser;
  uploadImage() async {
    flag = false;
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://69f3-111-68-99-41.in.ngrok.io/secondImage"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);

    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    print(message);
    Fluttertoast.showToast(msg: message.toString());
    second_Image = selectedImage;

    setState(() {
      flag = true;
      selectedImage = null;
    });


  }

  Future pickImage(ImageSource source) async {
    // var camerapermission = await Permission.camera;
    // var gallerypermission = await Permission.photos;
    // var image = await ImagePicker().pickImage(source: source);
    // if (image == null) return;
    // final imageTemporary = File(image.path);
    // image = imageTemporary as XFile?;
    // return image;

    final pickedImage =
    await ImagePicker().getImage(source: source, imageQuality: 85);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return flag==false?LoadingScreen():Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("Face Detection"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Stack(children: [
                    selectedImage == null
                        ? Container(
                      color: secondaryColor,
                    )
                        : Container(
                      color: secondaryColor,
                    ),
                    SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        selectedImage == null
                            ? Image.asset(
                          'assets/images/face-detection.png',
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .3,
                        )
                        // : Image.file(selectedImage!),
                            : Image.file(
                          selectedImage!,
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(
                                "\u2022 Clear camera lens before taking the picture",
                                maxLines: 3,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11, color: primaryColor)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(
                                "\u2022 Take picture at a suitable distance from Mechanic's face",
                                maxLines: 3,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11, color: primaryColor)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Text(
                                "\u2022 Click on the UPLOAD button after capturing the picture",
                                maxLines: 3,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11, color: primaryColor)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton.roundedButton(
                                context, "assets/images/check.png", "",
                                onTap: () {
                                  setState(() {
                                    flag = false;

                                  });
                                  uploadImage();
                                  signUp(widget.email.toString(), widget.password.toString());
                                }),
                            GestureDetector(
                                onTap: () => {pickImage(ImageSource.camera)},
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius:
                                        BorderRadius.circular(70.0),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: secondaryColor,

                                        radius: 40, // Image radius
                                        child: Image.asset(
                                          "assets/images/camera.png",
                                          height: 50,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = widget.email;
    userModel.password = widget.password;
    userModel.cnic = widget.cnic;
    userModel.fullName = widget.fullName;
    userModel.profession = "Visitor";
    userModel.profileImageReference = widget.profileImageReference;
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(userModel.toMapRegistrationDetails());
    Fluttertoast.showToast(msg: "Your account has been created successfully");
    Navigator.pushNamed(context, "/login");
  }

  void signUp(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
