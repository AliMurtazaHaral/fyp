import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/screens/loading_screen.dart';
import 'package:fyp/utils/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/img.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/parser.dart' as parser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/userModel.dart';
import '../widgets/buttons.dart';

class DetectScreen extends StatefulWidget {
  DetectScreen();

  @override
  DetectScreenState createState() => new DetectScreenState();
}

class DetectScreenState extends State<DetectScreen> {
  bool flag = true;
  File? selectedImage;
  File? second_Image;
  String? message = "";
  String? bg_image = "";
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc("LQ0PFtnsaxXU1c4tY0ZM")
        .collection("Visitor")
        .doc(user!.uid).get()
        .then((value) {
      loggedInUser = UserModel.fromMapRegsitration(value.data());
      setState(() {});
    });
  }

  // Web scrapping data for animals
  Future<List<String>> extractData( String name ) async {
    String lights = "https://www.pakwheels.com/accessories-spare-parts/search/-/buynow_1/?q=";
    String brakes = "https://www.pakwheels.com/accessories-spare-parts/search/-/buynow_1/?q=";
    String clutch = "https://www.pakwheels.com/accessories-spare-parts/search/-/buynow_1/?q=";
    String oil = "https://www.pakwheels.com/accessories-spare-parts/search/-/buynow_1/?q=";
    String filter = "https://www.pakwheels.com/accessories-spare-parts/search/-/buynow_1/?q==";
    // Getting the response from the targeted url
    final lightResponse =
    await http.Client().get(Uri.parse(lights+name+"+lights"));
    final brakeResponse =
    await http.Client().get(Uri.parse(brakes+name+"+brakes"));
    final clutchResponse =
    await http.Client().get(Uri.parse(clutch+name+"+clutch"));
    final oilResponse =
    await http.Client().get(Uri.parse(oil+name+"+oil"));
    final filterResponse =
    await http.Client().get(Uri.parse(filter+name+"+filter"));

    // Status Code 200 means response has been received successfully
    if (lightResponse.statusCode == 200 || brakeResponse.statusCode == 200 || oilResponse.statusCode == 200 || filterResponse.statusCode == 200 || clutchResponse.statusCode == 200) {

      // Getting the html document from the response
      var documentLight = parser.parse(lightResponse.body);
      var documentBrake = parser.parse(brakeResponse.body);
      var documentFilter = parser.parse(filterResponse.body);
      var documentOil = parser.parse(oilResponse.body);
      var documentClutch = parser.parse(clutchResponse.body);
      try {

        // Scraping the first article title
        var lightRes = "",brakeRes = "",oilRes = "",filterRes = "",clutchRes = "";
        lightRes = documentLight
            .getElementsByClassName('well search-list clearfix ad-container page-')[0]
            .children[1]
            .children[0]
            .children[0].children[0].children[0].children[0].text.trim();
        brakeRes = documentBrake
            .getElementsByClassName('list-unstyled accessory search-results search-results-mid accessory-search-results grid-view-layout grid-view')[0]
            .children[0]
            .children[0]
            .children[1].children[0].children[0].children[0].children[0].children[0].text.trim();
        oilRes = documentOil
            .getElementsByClassName('list-unstyled accessory search-results search-results-mid accessory-search-results grid-view-layout grid-view')[0]
            .children[0]
            .children[0]
            .children[1].children[0].children[0].children[0].children[0].children[0].text.trim();
        filterRes = documentFilter
            .getElementsByClassName('list-unstyled accessory search-results search-results-mid accessory-search-results grid-view-layout grid-view')[0]
            .children[0]
            .children[0]
            .children[1].children[0].children[0].children[0].children[0].children[0].text.trim();
        clutchRes = documentClutch
            .getElementsByClassName('list-unstyled accessory search-results search-results-mid accessory-search-results grid-view-layout grid-view')[0]
            .children[0]
            .children[0]
            .children[1].children[0].children[0].children[0].children[0].children[0].text.trim();
        // Scraping the forth article title

        // Converting the extracted titles into
        // string and returning a list of Strings
        return [
          lightRes+" ",
          brakeRes+" ",
          oilRes+" ",
          filterRes+" ",
          clutchRes+" ",
        ];
      }  catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${brakeResponse.statusCode}.'];
    }
  }



  uploadImage() async{
    final request = http.MultipartRequest(
        "POST" , Uri.parse("https://fec5-182-188-184-183.eu.ngrok.io/upload")
    );
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);

    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    print(message);
    Fluttertoast.showToast(msg: message.toString());
    second_Image = selectedImage;
    final carInfo = await extractData(message!);
    setState(() {
      selectedImage = null;
      flag = true;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.all(0.0),
            backgroundColor: Colors.white,
            scrollable: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(second_Image! ,
                    height: 150,
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Name: ",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      message!,
                      style: TextStyle(
                          color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Lights: ",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      carInfo[0],
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Brakes: ",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.4,
                      child: Text(carInfo[2], maxLines: 3,
                          softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: primaryColor)),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Oil: ",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.4,
                      child: Text(carInfo[2], maxLines: 3,
                          softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: primaryColor)),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Filter: ",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.4,
                      child: Text(carInfo[3], maxLines: 3,
                          softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: primaryColor)),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Clutch: ",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width*0.4,
                      child: Text(carInfo[4], maxLines: 3,
                          softWrap: false,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, color: primaryColor)),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          );
        });
  }

  Future pickImage(ImageSource source) async {
    final pickedImage =
    await ImagePicker().getImage(source: source , imageQuality: 85);
    selectedImage = File(pickedImage!.path);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return flag==false?LoadingScreen():Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Vehicle Detection"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(children: [
                    selectedImage == null?
                    Container(color: secondaryColor,
                    ):Container(
                      color: secondaryColor,
                    ),


                    SingleChildScrollView(
                      child: Column(

                          children:[
                            SizedBox(
                              height: MediaQuery.of(context).size.height *0.08,
                            ),
                            selectedImage == null
                                ? Image.asset(
                              'assets/images/car-detection.png',
                              width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .3,
                            )
                            // : Image.file(selectedImage!),
                                : Image.file(
                              selectedImage!,
                              width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .3,
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height *0.05,),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: const Text(
                                    "\u2022 Clear camera lens before taking the picture",
                                    maxLines: 3,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 11, color: primaryColor)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: const Text(
                                    "\u2022 Take a clear picture from front",
                                    maxLines: 3,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 11, color: primaryColor)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: const Text(
                                    "\u2022 Take a picture from a suitable distance",
                                    maxLines: 3,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 11, color: primaryColor)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: Text(
                                    "\u2022 Click on check button after capturing picture.",
                                    maxLines: 3,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 11, color: primaryColor)),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () => {pickImage(ImageSource.camera)},
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.green),
                                            borderRadius:
                                            BorderRadius.circular(70.0),
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: secondaryColor,

                                            radius: 40, // Image radius
                                            child: Image.asset(
                                              "assets/images/camera.png",
                                              height: 50,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                GestureDetector(
                                    onTap: () => {pickImage(ImageSource.gallery)},
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.green),
                                            borderRadius:
                                            BorderRadius.circular(70.0),
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: secondaryColor,

                                            radius: 40, // Image radius
                                            child: Image.asset(
                                              "assets/images/gallery.png",
                                              height: 100,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                            RoundedButton.roundedButton(
                                context, "assets/images/check.png", "",
                                onTap: () {
                                  setState(() {
                                    flag = false;
                                  });
                                  uploadImage();
                                }),
                          ]
                      ),

                    ),
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}