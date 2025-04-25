import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String text;
  final Map<String, dynamic> user;
  final DateTime createdAt;

  ChatMessageModel({
    required this.text,
    required this.user,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['text'] as String,
      user: Map<String, dynamic>.from(json['user']),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    data['user'] = user;
    data['createdAt'] = Timestamp.fromDate(createdAt);
    return data;
  }
}
