import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/fonts.dart';

Widget secondaryButton(BuildContext context, String text, String navigator) {
  return Container(
      color: primaryColor,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: MaterialButton(

            padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
            minWidth: MediaQuery.of(context).size.width * 0.8,
            onPressed: () {
              Navigator.pushNamed(context, navigator);
            },
            child: AutoSizeText(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    
                    color: Colors.white,
                    fontWeight: FontWeight.normal),

            ),),
      ),);
}

class RoundedButton {
  static Widget roundedButton(
      BuildContext context, String imagePath, String text,
      {Function? onTap}) {
    return GestureDetector(
        onTap: () => {onTap!()},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(70.0),
              ),
              child: CircleAvatar(
                backgroundColor: secondaryColor,

                radius: 40, // Image radius
                child: Image.asset(
                  imagePath,
                  height: 50,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
class CategoryButton {
  static Widget categoryButton(
      BuildContext context, String imagePath, String text,
      {Function? onTap}) {
    return GestureDetector(
        onTap: () => {onTap!()},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(70.0),
              ),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 60, // Image radius
                child: Image.asset(
                  imagePath,
                  height: 100,
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.height*0.1,
              child: Align(
                alignment: Alignment.center,
                child: Text(text, maxLines: 3,
                    softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ),

          ],
        ));
  }
}
class RegistrationTypeButton {
  static Widget registrationTypeButton(
      BuildContext context, String imagePath, String text,
      {Function? onTap}) {
    return GestureDetector(
        onTap: () => {onTap!()},
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFf4f4f4),
              radius: 80, // Image radius
              child: Image.asset(
                imagePath,
                height: 80,
              ),
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
class FilterButton {
  static Widget filterButton(BuildContext context, String text,
      {Function? onTap}) {
    return GestureDetector(
      onTap: () => {onTap!()},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Text(text, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class PrimaryButton {
  static Widget primaryButton(BuildContext context, String text,
      {Function? onPressed}) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: primaryColor,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
          minWidth: MediaQuery.of(context).size.width * 0.7,
          onPressed: () {
            onPressed!();
          },
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.yellow,
                fontWeight: FontWeight.normal),
          )),
    );
  }
}

class CustomWidgets {
  static Widget socialButtonRect(title, color, icon, {Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget socialButtonCircle(color, icon, {iconColor, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
          //width: 50.0,
          //height: 50.0,
          padding: const EdgeInsets.all(20.0),
          //I used some padding without fixed width and height
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // You can use like this way or like the below line
            //borderRadius: new BorderRadius.circular(30.0),
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor,
          ) // You can add a Icon instead of text also, like below.
          //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
          ), //
    );
  }
}
