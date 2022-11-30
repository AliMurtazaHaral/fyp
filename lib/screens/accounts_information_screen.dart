import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/fonts.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({Key? key}) : super(key: key);

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            // Add one stop for each color
            // Values should increase from 0.0 to 1.0
            stops: [0.2, 0.7],
            colors: [gradiantColor1, gradiantColor2],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const Image(
                  image: NetworkImage(
                      'https://www.tutorialkart.com/img/hummingbird.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
