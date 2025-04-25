// ChatMessage(
//   text: 'Hi',
//   user: ChatUser(id: '2'),
//   createdAt: DateTime.now(),
// ),

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/store/providers/user_provider.dart';
import 'package:flutter_application_1/app/store/services/chat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chat extends ConsumerStatefulWidget {
  const Chat({super.key});

  @override
  ConsumerState<Chat> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  Future<void> sendMessage(ChatMessage message) async {
    try {
      final uid = ref.read(userStateProvider).id;
      ChatService().addMessage(uid, message.text);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print('📛 StackTrace: $stackTrace');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(userStateProvider).id;
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Color.fromRGBO(233, 237, 238, 1))),
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            color: const Color.fromRGBO(233, 237, 238, 1),
            height: 1.0,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('messages')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final messages = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ChatMessage(
                text: data['text'] ?? '',
                user: ChatUser(id: data['user']['id'] ?? ''),
                createdAt: (data['createdAt'] as Timestamp?)?.toDate() ??
                    DateTime.now(),
              );
            }).toList();

            return DashChat(
                inputOptions: InputOptions(
                  inputTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  sendButtonBuilder: (send) {
                    return IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: send,
                    );
                  },
                ),
                messageOptions: MessageOptions(messageDecorationBuilder:
                    (message, previousMessage, nextMessage) {
                  return BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  );
                }),
                currentUser:
                    ChatUser(id: uid, firstName: 'user', lastName: '1'),
                onSend: sendMessage,
                messages: messages);
          }),
    );
  }
}
