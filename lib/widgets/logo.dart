import 'package:flutter/cupertino.dart';

Widget logoOpeningPage(BuildContext context, Animation<double> controller) {
  return RotationTransition(
      turns: controller, child: Image.asset("assets/images/logo.png"));
}

Widget logoRemainingPage(BuildContext context, Animation<double> controller) {
  return RotationTransition(
      turns: controller,
      child: Image.asset(
        "assets/images/logo.png",
        height: 200,
        width: 200,
      ));
}
