import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/screens/face_detection_customer_screen.dart';
import '../models/storage_model.dart';
import '../models/userModel.dart';
import '../utils/fonts.dart';
import '../widgets/buttons.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final fullNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final cnicEditingController = TextEditingController();
  final cityEditingController = TextEditingController();
  final mobileNumberEditingController = TextEditingController();
  final uploadEditingController = TextEditingController();
  final StorageModel storage = StorageModel();
  late Reference getUrl;
  late Reference getShopUrl;

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
      decoration: const InputDecoration(
        fillColor: Colors.white,
        border: UnderlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Full Name",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    //CNIC field
    final cnicField = TextFormField(
      autofocus: false,
      controller: cnicEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter CNIC here");
        }
        return null;
      },
      onSaved: (value) {
        cnicEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        border: UnderlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "xxxxx-xxxxxxx-x",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    //City Field
    final cityField = TextFormField(
      autofocus: false,
      controller: cityEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your City");
        }
        return null;
      },
      onSaved: (value) {
        cityEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "City",
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    //Mobile Number Field
    final mobileNumberField = TextFormField(
      autofocus: false,
      controller: mobileNumberEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Mobile Number");
        }
        return null;
      },
      onSaved: (value) {
        mobileNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mobile Number",
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
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
              style: TextStyle(color: Colors.yellow, fontSize: buttonTextSize),
            ),
          ),
        ),
      ),
    );

    //signup button
    final signUpButton =
        PrimaryButton.primaryButton(context, "Next", onPressed: () {
      if (emailEditingController.text.isNotEmpty &&
          emailEditingController.text.isNotEmpty &&
          fullNameEditingController.text.isNotEmpty &&
          cnicEditingController.text.isNotEmpty &&
          passwordEditingController.text.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerFaceDetectionScreen(
                    fullName: fullNameEditingController.text,
                    cnic: cnicEditingController.text,
                    email: emailEditingController.text,
                    password: passwordEditingController.text,
                    profession: "Visitor",
                    profileImageReference: getUrl.fullPath.toString())));
      } else {
        Fluttertoast.showToast(
            msg: "Some fields are missing, please them as well");
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.yellow,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  defaultPadding, 25, defaultPadding, defaultPadding),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(centralPadding)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: appBarSize,
                              color: textColor),
                        ),
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      fullNameField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      emailField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      cnicField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      cityField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      mobileNumberField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      passwordField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      confirmPasswordField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      dottedBoder,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      signUpButton,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .08,
                      ),
                    ],
                  ),
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

    userModel.email = emailEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.cnic = cnicEditingController.text;
    userModel.fullName = fullNameEditingController.text;
    userModel.profession = "Visitor";
    userModel.profileImageReference = getUrl.fullPath.toString();
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

  signUpChecker() {
    signUp(emailEditingController.text, passwordEditingController.text);
  }
}
