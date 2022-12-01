import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import '../../../services/database.dart';
import '../../../utils/fonts.dart';
import '../widget/widgets.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String myName;
  final String userName;
  final String currentU;
  ConversationScreen(
      {required this.chatRoomId, required this.myName, required this.userName, required this.currentU});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  // -------------------------------------------------------------- //
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatMessageStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageEditingController = new TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var joined = false;
  var remoteUid = 0;
  var switched = false;
  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        return streamSnapshot.hasData
            ? ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> map = streamSnapshot.data!.docs[index]
                      .data() as Map<String, dynamic>;
                  return MessageTile(
                    map: map,
                    message: streamSnapshot.data!.docs[index]["message"],
                    sendByMe: widget.myName ==
                        streamSnapshot.data!.docs[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  File? imageFile;
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      uploadImage();
    }
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      Map<String, dynamic> messageMap = {
        "sendBy": widget.myName,
        "message": imageUrl,
        'time': DateTime.now().millisecondsSinceEpoch,
        "type": "img",
      };
      databaseMethods.addConversationMessage(widget.chatRoomId, messageMap);

      print(imageUrl);
    }
  }

  sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "sendBy": widget.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        "type": "text",
      };
      databaseMethods.addConversationMessage(widget.chatRoomId, messageMap);
      late DocumentSnapshot snap;
      String m = messageEditingController.text;
      setState(() async {
        if(widget.currentU==widget.chatRoomId.split('_')[0]){
          snap = await FirebaseFirestore.instance.collection(
              "users").doc(widget.chatRoomId.split('_')[1]).get();
        }
        else{
          snap = await FirebaseFirestore.instance.collection(
              "users").doc(widget.chatRoomId.split('_')[1]).get();
        }
        messageEditingController.text = "";
      });
      String token = snap['token'];
      print(token);

      sendPushMessage(token, widget.myName, m);
    }

  }
  String? mtoken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel channel;
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
    if(widget.currentU==widget.chatRoomId.split('_')[0]){
      await FirebaseFirestore.instance.collection("users").doc(widget.chatRoomId.split('_')[1]).update({
        'token' : token,
      });
    }
    else{
      await FirebaseFirestore.instance.collection("users").doc(widget.chatRoomId.split('_')[1]).update({
        'token' : token,
      });
    }
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
  void initState() {
    super.initState();

    databaseMethods.getConversationMessage(widget.chatRoomId).then((value) {

      setState(() {
        chatMessageStream = value;
      });
    });
    requestPermission();
    loadFCM();
    listenFCM();
    getToken();
  }

  // -------------------------------------------------------------- //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        color: secondaryColor,
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: chatMessageList(),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => getImage(),
                                icon: const Icon(Icons.photo),
                              ),
                              border: InputBorder.none,
                              hintText: 'Message...',
                              hintStyle: TextStyle(color: Colors.black45)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0x36FFFFFF),
                                    Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset(
                            "assets/images/send.png",
                            height: 30,
                            width: 30,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final Map<String, dynamic> map;
  const MessageTile(
      {required this.message, required this.sendByMe, required this.map});

  @override
  Widget build(BuildContext context) {
    return map['type'] == 'text'
        ? Container(
            padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: sendByMe ? 0 : 24,
                right: sendByMe ? 24 : 0),
            alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: sendByMe
                  ? EdgeInsets.only(left: 30)
                  : EdgeInsets.only(right: 30),
              padding:
                  EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: sendByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomLeft: Radius.circular(23))
                      : BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomRight: Radius.circular(23)),
                  gradient: LinearGradient(
                    colors: sendByMe
                        ? [const Color(0xff000000), const Color(0xff000000)]
                        : [const Color(0xff000000), const Color(0xff000000)],
                  )),
              child: Text(message,
                  textAlign: TextAlign.start, style: chatRoomTileStyle()),
            ),
          )
        : Container(
            padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: sendByMe ? 0 : 24,
                right: sendByMe ? 24 : 0),
            alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(border: Border.all()),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
