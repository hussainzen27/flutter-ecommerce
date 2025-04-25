import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/app/store/models/chat_model.dart';

class ChatService {
  //Add Conversation

  // Add message in conversation
  Future<void> addMessage(String senderId, String message) async {
    try {
      final user = ChatUser(id: senderId);
      final userJson = user.toJson();
      final chatMessage = ChatMessageModel(
        text: message,
        user: userJson,
        createdAt: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection('messages')
          .add(chatMessage.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print('📛 StackTrace: $stackTrace');
      }
    }
  }
}
