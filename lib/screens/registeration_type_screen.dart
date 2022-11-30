import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/fonts.dart';
import '../widgets/buttons.dart';

class RegistrationTypeScreen extends StatefulWidget {
  const RegistrationTypeScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationTypeScreen> createState() => _RegistrationTypeScreenState();
}

class _RegistrationTypeScreenState extends State<RegistrationTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: secondaryColor,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(centralPadding)),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'CHOOSE CATEGORY',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryButton.categoryButton(
                            context, "assets/images/customer.png", "Customer",
                            onTap: () {
                          Navigator.pushNamed(context, "/registration");
                        }),
                        CategoryButton.categoryButton(
                            context, "assets/images/mechanic.png", "Mechanic",
                            onTap: () {
                          Navigator.pushNamed(context, "/mechanicRegistration");
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryButton.categoryButton(
                            context, "assets/images/rider.png", "Rider",
                            onTap: () {
                          Navigator.pushNamed(context, "/riderRegistration");
                        }),
                        CategoryButton.categoryButton(
                            context, "assets/images/back.png", "Go Back",
                            onTap: () {
                          Navigator.pushNamed(context, "/loginSignup");
                        }),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void postDetails() {
    print("enter ");
  }
}
