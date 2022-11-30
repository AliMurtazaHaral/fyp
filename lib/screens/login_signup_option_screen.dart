
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../utils/fonts.dart';
import '../widgets/buttons.dart';

class SignUpLogin extends StatefulWidget {
  const SignUpLogin({Key? key}) : super(key: key);

  @override
  _SignUpLoginState createState() => _SignUpLoginState();
}

class _SignUpLoginState extends State<SignUpLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.20,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo_completed.jpeg",
                        height: 200,
                        width: 200,
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'JOIN US!',
                      style: TextStyle(
                        fontSize: 30,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                secondaryButton(context, "Sign Up", "/registrationType"),
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                secondaryButton(context, "Login", "/login"),
              ],
            ),
          ),
    );
  }
}
