import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/rate_screen.dart';
import 'package:fyp/utils/fonts.dart';

class BookMechanicScreen extends StatefulWidget {
  BookMechanicScreen({Key? key,required this.mechanicName, required this.customerName,required this.status, required this.address, required this.uniId}) : super(key: key);
  String? customerName;
  String? mechanicName;
  String? address;
  String? status;
  String? uniId;

  @override
  State<BookMechanicScreen> createState() => _BookMechanicScreenState();
}

class _BookMechanicScreenState extends State<BookMechanicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor, brightness: Brightness.dark,
          title: Text("Booked Mechanic"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {Navigator.pop(context);},
          ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[

                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Mechanic Name: ${widget.mechanicName}", style: TextStyle(color: primaryColor)),
                            Container(height: 2),
                            Text("Booked", style: TextStyle(color: primaryColor))
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.info, color: primaryColor), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                              Text("Mechanic will be arrived soon", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),textAlign: TextAlign.left,),
                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.sync, color: primaryColor), width: 50),
                        Container(width: 15),
                        Text("Approximately in 30 minutes", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Select Payment Method", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.payments, color: primaryColor), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Cash Payment", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.payment, color: primaryColor), width: 50),
                        Container(width: 15),
                        InkWell(
                          onTap: () async{
                            print('Text Clicked');

                            Navigator.pushNamed(context, '/paymentStripe');
                          },
                          child: Text("Online Payment", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("Your Information", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.person, color: primaryColor), width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name: ${widget.customerName}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500)),
                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(child: Icon(Icons.location_on, color: primaryColor), width: 50),
                        Container(width: 15),
                        Expanded(
                          child: Text("${widget.address}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                minWidth: MediaQuery.of(context).size.width * 0.5,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RateScreen(uniId:widget.uniId)));
                },
                child: const Text(
                  'Rate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),

                ),),
            ),
          ],
        ),
      ),
    );
  }
}
