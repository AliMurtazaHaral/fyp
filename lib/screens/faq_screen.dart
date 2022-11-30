import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text(widget.title,style: TextStyle(color: Colors.yellow),),
          trailing: IconButton(
            icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: Colors.yellow,),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Container(
          color: Colors.black,
          padding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Text(widget.content,style: TextStyle(color: Colors.yellow),),
        )
            : Container()
      ]),
    );
  }
}
class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'F A Q',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: const [
            Accordion(
              title: 'What assets can I track?',
              content:
              'MTData’s integrated solutions have been developed over almost 20 years; allowing you to track almost anything, including vehicles, trailers, dollies, containers and equipment. Depending on the specific requirement, you can select from powered and battery / solar powered options. Get in touch today to discuss tracking all your moveable assets in one central location.',
            ),
            Accordion(
              title: 'What are my options for managing driver fatigue?',
              content:
              'Our easy-to-use driver tool, Talon, proactively manages fatigue compliance with our module, Complete Fatigue. Complete Fatigue incorporates different State-based schemes and calculates complex fatigue-related requirements simultaneously. Drivers can clearly see the required rest periods throughout their shift. ',
            ),
            Accordion(
                title: 'Why should I have Mobile Digital Video Recording cameras installed?',
                content:
                'MTData’s integrated Mobile Digital Video Recording (MDVR) system includes up to four cameras recording the vehicle’s surroundings and cabin for incident replay. Being able to quickly review footage enables managers to respond accordingly in an emergency. Recorded footage can be instrumental in improving driver behaviour and can also be used as evidence if further proof is required. '
            ),
            Accordion(
                title: 'How do I get the returns on Fuel Tax Credits?',
                content:
                'Fuel Tax Credits (FTC) can be applied against the cost of fuel used when driving on non-public roads for business purposes. MTData works closely with a third party who use an FTC calculation module to accurately estimate Fuel Tax Credits from usage data collected. '
            ),
            Accordion(
                title: 'What does Intelligent Access Program mean for me?',
                content:
                'Intelligent Access Program (IAP) forms part of the National Telematics Framework. IAP provides transport operators with greater road access to increase productivity and maximise margins. Heavy vehicles must be fitted with an IAP approved In Vehicle Monitoring System (IVMS). MTData’s solutions are IAP certified. State authority approval is required to access IAP and you must notify them of your designated route.  '
            ),
          ]),
        )
    );
  }
}
