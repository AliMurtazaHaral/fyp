import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//imported google's material design library
class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Stream<QuerySnapshot<Map<String, dynamic>>> foundOfficers =
  FirebaseFirestore.instance.collection('Officer').snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> foundDrivers =
  FirebaseFirestore.instance.collection('driver').snapshots();
  int? totalDriver = 0;
  int? totalOfficer = 0;

  @override
  void initState(){
    super.initState();

  }
  Future<String> totalD(int? a)async{

      totalDriver = a;

    return await '';
  }
  Future<String> totalO(int? a)async{

      totalOfficer = a;

      return await '';
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        backgroundColor: const Color(0xb00d4d79),
        centerTitle: true,
      ), //AppBar
      body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: foundDrivers,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  List<Widget> Data = [];
                  var image_2;
                  final product = streamSnapshot.data?.docs;
                  return product?.length != 0
                      ? SingleChildScrollView(
                    child: Column(children: [
                      for (var data in product!)

                        FutureBuilder<String>(
                            future: totalD(product.length),
                            builder: (_, imageSnapshot) {
                              final imageUrl = imageSnapshot.data;
                              return const SizedBox();
                            })
                    ]),
                  )
                      : SizedBox(height: 0,);
                },
              ),

              StreamBuilder(
                stream: foundOfficers,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  List<Widget> Data = [];
                  var image_2;
                  final product = streamSnapshot.data?.docs;
                  return product?.length != 0
                      ? SingleChildScrollView(
                    child: Column(children: [
                      for (var data in product!)

                        FutureBuilder<String>(
                            future: totalO(product.length),
                            builder: (_, imageSnapshot) {

                              return const SizedBox();
                            })
                    ]),
                  )
                      : SizedBox(height: 0,);
                },
              ),
              Center(
                /* Card Widget */
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: const Color(0xffffffff),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/justlogo.PNG',),), //CircleAvatar
                          ), //CircleAvatar
                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          Text(
                            'Total Users',
                            style: TextStyle(
                              fontSize: 30,
                              color: const Color(0xff0b2242),
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ),

                          Text(
                            (totalDriver!+totalOfficer!).toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff0b2242),
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ),//Text
                          const SizedBox(
                            height: 10,
                          ), //SizedBox

                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          SizedBox(
                            width: 100,

                            child: ElevatedButton(
                              onPressed: () => 'Null',
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(Icons.touch_app),
                                    Text('Visit')
                                  ],
                                ),
                              ),
                            ),
                            // RaisedButton is deprecated and should not be used
                            // Use ElevatedButton instead

                            // child: RaisedButton(
                            // onPressed: () => null,
                            // color: Colors.green,
                            // child: Padding(
                            //	 padding: const EdgeInsets.all(4.0),
                            //	 child: Row(
                            //	 children: const [
                            //		 Icon(Icons.touch_app),
                            //		 Text('Visit'),
                            //	 ],
                            //	 ), //Row
                            // ), //Padding
                            // ), //RaisedButton
                          ) //SizedBox
                        ],
                      ), //Column
                    ), //Padding
                  ), //SizedBox
                ),
                //Card
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                /* Card Widget */
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: const Color(0xffffffff),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/justlogo.PNG',),), //CircleAvatar
                          ), //CircleAvatar
                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          Text(
                            'Drivers',
                            style: TextStyle(
                              fontSize: 25,
                              color: const Color(0xff0b2242),
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ),

                          Text(
                            totalDriver.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff0b2242),
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ),//Text
                          const SizedBox(
                            height: 10,
                          ), //SizedBox

                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          SizedBox(
                            width: 100,

                            child: ElevatedButton(
                              onPressed: () => 'Null',
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(Icons.touch_app),
                                    Text('Visit')
                                  ],
                                ),
                              ),
                            ),
                            // RaisedButton is deprecated and should not be used
                            // Use ElevatedButton instead

                            // child: RaisedButton(
                            // onPressed: () => null,
                            // color: Colors.green,
                            // child: Padding(
                            //	 padding: const EdgeInsets.all(4.0),
                            //	 child: Row(
                            //	 children: const [
                            //		 Icon(Icons.touch_app),
                            //		 Text('Visit'),
                            //	 ],
                            //	 ), //Row
                            // ), //Padding
                            // ), //RaisedButton
                          ) //SizedBox
                        ],
                      ), //Column
                    ), //Padding
                  ), //SizedBox
                ),
                //Card
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                /* Card Widget */
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: const Color(0xffffffff),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/justlogo.PNG',),), //CircleAvatar
                          ), //CircleAvatar
                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          Text(
                            'Police Officers',
                            style: TextStyle(
                              fontSize: 30,
                              color: const Color(0xff0b2242),
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ),
                          Text(
                            totalOfficer.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff0b2242),
                              fontWeight: FontWeight.w500,
                            ), //Textstyle
                          ),//Text
                          const SizedBox(
                            height: 10,
                          ), //SizedBox

                          const SizedBox(
                            height: 10,
                          ), //SizedBox
                          SizedBox(
                            width: 100,

                            child: ElevatedButton(
                              onPressed: () => 'Null',
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(Icons.touch_app),
                                    Text('Visit')
                                  ],
                                ),
                              ),
                            ),

                            // RaisedButton is deprecated and should not be used
                            // Use ElevatedButton instead

                            // child: RaisedButton(
                            // onPressed: () => null,
                            // color: Colors.green,
                            // child: Padding(
                            //	 padding: const EdgeInsets.all(4.0),
                            //	 child: Row(
                            //	 children: const [
                            //		 Icon(Icons.touch_app),
                            //		 Text('Visit'),
                            //	 ],
                            //	 ), //Row
                            // ), //Padding
                            // ), //RaisedButton
                          )
                          //SizedBox
                        ],
                      ), //Column
                    ), //Padding
                  ), //SizedBox
                ),
                //Card
              ),
            ],
          )
      ), //Center
    );
  }
}