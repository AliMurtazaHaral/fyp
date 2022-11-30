import 'package:flutter/material.dart';

class Distracter extends StatefulWidget {
  bool showImage = false;
  Distracter({
    Key? key,
  }) : super(key: key);

  @override
  State<Distracter> createState() => _DistracterState();
}

class _DistracterState extends State<Distracter>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 4),
    )
      ..addListener(() {
        if (controller.status == AnimationStatus.completed) {
          controller.reverse();
        }
        if (controller.status == AnimationStatus.dismissed) {
          controller.forward();
        }
        setState(() {});
      })
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showD1() {
      if (controller.status == AnimationStatus.forward) {
        widget.showImage = true;
      }
      if (controller.status == AnimationStatus.reverse) {
        widget.showImage = false;
      }
      if (widget.showImage) {
        return SizedBox(
            height: 110,
            child: Image.asset(
              "assets/images/character_robot_attack0.png",
              fit: BoxFit.contain,
            ));
      } else {
        return const SizedBox(
          height: 110,
        );
      }
    }

    return showD1();
  }
}
