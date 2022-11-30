import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../models/userModel.dart';
import '../utils/fonts.dart';
import '../utils/notifications.dart';
import '../widgets/buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
  {

  String _dropDownValue = 'Guest';


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState(){
    super.initState();
    NotificationWidget.init();
  }
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle: const TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: const TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //forget password
    final forgetPassword = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/forgetPassword');
      },
      child: const Text(
        '\nForget Password?',
        style: TextStyle(
            color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
    final dropdownField = DropdownButton(
      hint: Text(
        _dropDownValue,
        style: TextStyle(color: primaryColor),
      ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: primaryColor),
      items: ['Guest', 'Mechanic', 'Rider'].map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            _dropDownValue = val.toString();
          },
        );
      },
    );
    //signIn button
    final signInButton =
        PrimaryButton.primaryButton(context, "Login", onPressed: () {
      if (_dropDownValue.toString() == "Guest") {
        signInVisitor(emailController.text, passwordController.text);
      }
      if (_dropDownValue.toString() == "Mechanic") {
        signInMechanic(emailController.text, passwordController.text);
      }
      if (_dropDownValue.toString() == "Rider") {
        signInDeliveryBoy(emailController.text, passwordController.text);
      }
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: primaryColor,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: appBarSize,
                              color: textColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/logo.png",
                              height: 200,
                              width: 200,
                            )),
                      ),
                      emailField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      passwordField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      dropdownField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      signInButton,
                      forgetPassword,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      CustomWidgets.socialButtonRect('Login with Facebook',
                          facebookColor, FontAwesomeIcons.facebookF, onTap: () {
                        signInWithFacebook();
                      }),
                      CustomWidgets.socialButtonRect('Login with Google',
                          googleColor, FontAwesomeIcons.google, onTap: () {
                        signInWithGoogle();
                      }),
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // login function
  void signInVisitor(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
    NotificationWidget.showNotifications(title: "Autom", body: "Successfully Logged In", payload: FlutterLocalNotificationsPlugin()),
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.pushNamed(context, '/dashboard'),

            })
        .catchError((e) {
      Fluttertoast.showToast(msg: "Login is not successful");
    });
  }
  void signInMechanic(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.pushNamed(context, '/mechanicDashboard'),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: "Login is not successful");
    });
  }

  void signInVendor(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: "Login is not successful");
    });
  }

  void signInDeliveryBoy(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.pushNamed(context, '/riderDashboard'),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: "Login is not successful");
    });
  }
}

class CheckerScreen extends StatefulWidget {
  const CheckerScreen({Key? key}) : super(key: key);

  @override
  State<CheckerScreen> createState() => _CheckerScreenState();
}

class _CheckerScreenState extends State<CheckerScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotationTransition(
            turns: controller,
            child: Image.asset(
              "assets/images/logo.png",
              height: 200,
              width: 200,
            )),
        functionIs("${loggedInUser.profession.toString()}")
      ],
    );
  }

  toDashboard() {}

  toVendorDashboard() {}
  toDevliveryBoyDashboard() {}
  toMechanicDashboard() {}

  functionIs(String s) {
    if (s == "Visitor") {
      Navigator.pushNamed(context, '/dashboard');
    } else if (s == "Mechanic") {
      Navigator.pushNamed(context, '/mechanicDashboard');
    } else if (s == "Delivery Boy") {
    } else {}
  }
}

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final emailController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Email Here",
        hintStyle: const TextStyle(
          color: Colors.grey, // <-- Change this
          fontSize: null,
          fontStyle: FontStyle.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final forgetPasswordButton =
        PrimaryButton.primaryButton(context, "Reset Password", onPressed: () {
      resetPasswordLink();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Reset Password"),
        ),
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Forget Password!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: appBarSize,
                  color: textColor),
            ),
          ),
          logoRemainingPage(context, controller),
          emailField,
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          forgetPasswordButton,
          SizedBox(
            height: MediaQuery.of(context).size.height * .08,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    if (emailController.text.isNotEmpty) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      Navigator.pushNamed(context, "/login");
    } else {
      Fluttertoast.showToast(msg: "You have entered wrong email");
    }
  }

  void resetPasswordLink() {
    resetPassword(emailController.text);
  }
}
