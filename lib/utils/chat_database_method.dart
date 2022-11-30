import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMethods {
  getUserByUserName(String username) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('fullName', isEqualTo: username)
        .get()
        .catchError((e) => print(e.toString()));
  }

  getUserByUserEmail(String userEmail) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get()
        .catchError((e) => print(e.toString()));
  }

  uploadUserInfo(userMap) async {
    FirebaseFirestore.instance
        .collection('users')
        .add(userMap)
        .catchError((e) => print(e.toString()));
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) => print(e.toString()));
  }

  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getChatRoom(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
