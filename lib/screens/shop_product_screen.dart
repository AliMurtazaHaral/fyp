import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';
import '../utils/fonts.dart';

class ShopProductScreen extends StatefulWidget {
  const ShopProductScreen({Key? key}) : super(key: key);

  @override
  State<ShopProductScreen> createState() => _ShopProductScreenState();
}

class _ShopProductScreenState extends State<ShopProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .30,
            decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            child: Center(
              child: Text(
                "Buy Products"
                    "",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/gear-lever.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Gear Lever",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/seat-belt.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Seat Belt",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/steering-wheel.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Steering Wheel",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/windscreen.jpeg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Wind Screen",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/speedometer.jpeg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Speedometer",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/headlights.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Head Lights",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/turn-signal.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Turn Signal",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/brakes.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Brakes",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/battery.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Battery",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.15,

            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor,
                  child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      onPressed: () {

                      },
                      child: Column(
                        children: [
                          Text("Gear Lever",style: TextStyle(
                              color: secondaryColor,fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("assets/images/radiator.jpg"),radius: 40,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Radiator",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 15),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("5 Star Reviews",style: TextStyle(
                                      color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                                ],
                              ),
                              Text("Rs:1000",style: TextStyle(
                                  color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10),),
                            ],
                          ),
                        ],
                      )
                  ),
                )
            ),
          ),
        ],
      )),
    );
  }
}

class PlanetRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planetThumbnail =  Container(
        margin: new EdgeInsets.symmetric(
        vertical: 16.0
            ),
        alignment: FractionalOffset.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: Image(
            image: AssetImage("assets/images/shop.jpg"),

          ),
        )
    );
    final planetCard = Container(
            height: MediaQuery.of(context).size.height*.3,
            width: MediaQuery.of(context).size.width*.92,
            margin:  EdgeInsets.only(left: 46.0),
        decoration:  BoxDecoration(
          color:  Color(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius:  BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
             BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            ),
          ],
        ),
      child: Text("Gear Lever"),
     );
    return Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ));
  }
}
