import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
class NotificationToUser extends StatefulWidget {
  const NotificationToUser({Key? key}) : super(key: key);

  @override
  State<NotificationToUser> createState() => _NotificationToUserState();
}

class _NotificationToUserState extends State<NotificationToUser> {
  String? mtoken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
  TextEditingController username = TextEditingController();
  TextEditingController title= TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging. instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted Permission');

    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User Granted Provincial Permission');

    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            mtoken = token;
            print("My token is $mtoken");
          });
          saveToken(token!);
        }
    );
  }

  void saveToken(String token) async{
    await FirebaseFirestore.instance.collection("users").doc("5xPe5klOgd189NEucm6q").update({
    'token' : token,
    });
  }
  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAApRzQFgg:APA91bGmDfXnC2DXElT_NdxH1NtP5ZETT94Un6Htv2eAzhirZI_mfbRP85ogDTpYs5opt06kjsFxkTx_pMeZxlEw4OBI2r7qHOHTne_XpC6AI0OTokb0YjJSkAHTCaNkTAofnR6ktABD',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body' : body,
            'title': title,
          },

          "notification": <String, dynamic>{
          "title": title,
          "body": body,
          "android_channel_id": "dbfood"
        },
          "to": token,
          },
        ),
      );
    } catch(e){
  if (kDebugMode){
  print("error push notification");
  }
  }
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 300,),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            color: Colors.yellow,
            child: MaterialButton(

              padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
              minWidth: MediaQuery.of(context).size.width * 0.8,
              onPressed: () async{
                String name = username.text.trim();
                String titleText = title.text;
                String bodyText = body.text;


                DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
                    "users").doc('5xPe5klOgd189NEucm6q').get();
                String token = snap['token'];
                print(token);
                sendPushMessage(token, 'this is body', 'this is text');
              },
              child: Text(
                "Click me",
                textAlign: TextAlign.center,
                style: const TextStyle(

                    color: Colors.white,
                    fontWeight: FontWeight.normal),

              ),),
          ),
          Container(
            child: GestureDetector(
                child: Text("send notification"),
                onTap: ()async {
                  String name = username.text.trim();
                  String titleText = title.text;
                  String bodyText = body.text;


                    DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
                        "UserTokens").doc(name).get();
                    String token = snap['token'];
                    print(token);
                    sendPushMessage(token, 'this is body', 'this is text');

                }
            ),
          ),
        ],
      )
    );
  }
}
