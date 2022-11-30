

import 'package:flutter/material.dart';

import 'distracter.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Distracter distracter = Distracter();
  late bool flag = distracter.showImage;
  @override
  Widget build(BuildContext context) {
    final btn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromARGB(255, 208, 99, 99),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width * 0.3,
          onPressed: () {},
          child: const Text(
            "Go",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Distracter(

              ),
              const SizedBox(
                height: 110,
              ),

            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),

          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 110,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          btn
        ]),
      ),
    );
  }
}
