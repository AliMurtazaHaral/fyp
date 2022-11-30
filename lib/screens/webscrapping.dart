import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;



class Animal_Info extends StatefulWidget {
  const Animal_Info({Key? key}) : super(key: key);

  @override
  State<Animal_Info> createState() => _Animal_InfoState();
}

class _Animal_InfoState extends State<Animal_Info> {
  String result1 = 'Result1';
  String result2 = 'Result2';
  String result3 = 'Result3';
  String result4 = 'Result4';

  bool isLoading = false;

  String car_name = "Honda_Civic";

  Future<List<String>> extractData( String name ) async {
    String car_url = "https://en.wikipedia.org/wiki/";
    // Getting the response from the targeted url
    final response =
    await http.Client().get(Uri.parse(car_url+car_name));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {

      // Getting the html document from the response
      var document = parser.parse(response.body);
      try {

        // Scraping the first article title
        int i = 0;
        var responseString1 = document
            .getElementsByClassName('infobox hproduct')[0]
            .children[0]
            .children[i ]
            .children[0];

        while( responseString1.text.trim()!= "Manufacturer"){
          print(responseString1.text.trim());
          responseString1 = document
              .getElementsByClassName('infobox hproduct')[0]
              .children[0]
              .children[i]
              .children[0];
          i++;
        }
        responseString1 = document
            .getElementsByClassName('infobox hproduct')[0]
            .children[0]
            .children[i-1]
            .children[1];



        // Scraping the second article title
        var responseString2 = document
            .getElementsByClassName('infobox hproduct')[0]
            .children[0]
            .children[i]
            .children[0];

        while( responseString2.text.trim()!= "Production"){
          print(responseString2.text.trim());
          responseString2 = document
              .getElementsByClassName('infobox hproduct')[0]
              .children[0]
              .children[i]
              .children[0];
          i++;
        }
        i--;
        responseString2 = document
            .getElementsByClassName('infobox hproduct')[0]
            .children[0]
            .children[i]
            .children[1];

        // Scraping the third article title
        var responseString3 = document
            .getElementsByClassName('infobox hproduct')[0]
            .children[0]
            .children[i]
            .children[0];

        while( responseString3.text.trim()!= "Class"){
          print(responseString3.text.trim());
          responseString3 = document
              .getElementsByClassName('infobox hproduct')[0]
              .children[0]
              .children[i]
              .children[0];
          i++;
        }
        i--;
        responseString3 = document
            .getElementsByClassName('infobox hproduct')[0]
            .children[0]
            .children[i]
            .children[1];

        print(responseString3.text.trim());

        // Scraping the forth article title

        // Converting the extracted titles into
        // string and returning a list of Strings
        return [
          responseString1.text.trim(),
          responseString2.text.trim(),
          responseString3.text.trim(),
        ];
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GeeksForGeeks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // if isLoading is true show loader
                // else show Column of Texts
                isLoading
                    ? CircularProgressIndicator()
                    : Column(
                  children: [
                    Text(result1,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(result2,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(result3,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),

                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                MaterialButton(
                  onPressed: () async {

                    // Setting isLoading true to show the loader
                    setState(() {
                      isLoading = true;
                    });

                    // Awaiting for web scraping function
                    // to return list of strings
                    final response = await extractData(car_name);

                    // Setting the received strings to be
                    // displayed and making isLoading false
                    // to hide the loader
                    setState(() {
                      result1 = response[0];
                      result2 = response[1];
                      result3 = response[2];
                      isLoading = false;
                    });
                  },
                  child: Text(
                    'Scrap Data',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                )
              ],
            )),
      ),
    );
  }
}