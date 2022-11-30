import 'package:flutter/material.dart';
import '../services/database.dart';
import '../screens/chat/views/conversationScreen.dart';

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
