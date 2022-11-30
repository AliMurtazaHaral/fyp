import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget{
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool schedule = false}) async{
    var initAndroidSettings = AndroidInitializationSettings('mipmap/ic_launcher');
    final settings = InitializationSettings(android: initAndroidSettings);
    await _notifications.initialize(settings);

  }
  static Future showNotifications( {
    var id=  0,
    var title,
    var body,
    var payload,
  } ) async => _notifications.show(id,title,body, await notificationDetails());

  static notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'Hello i am alert',
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        channelShowBadge: true,
        color: Colors.teal[800],
      ),
    );
  }
}