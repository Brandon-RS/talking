import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../../user/presentation/providers/logged_user_provider.dart';
import '../../../user/presentation/providers/logged_user_state.dart';
import '../../domain/entities/message_entity.dart';
import '../providers/chat_provider.dart';
import '../providers/chat_state.dart';
import '../widgets/chat.widgets.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(loggedUserProvider.select((value) => value is LoggedUserLoaded ? value.user : null));
    final targetUser = ref.watch(chatProvider.select((value) => value is ChatLoaded ? value.targetUser : User.empty()));

    final chats = ref.watch(chatProvider.select((value) => value is ChatLoaded ? value.messages : const []));

    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: chats.length,
              reverse: true,
              itemBuilder: (context, index) {
                final isMe = chats[index].from == loggedUser?.uid;

                return BubbleChat(
                  text: chats[index].text,
                  isMine: isMe,
                );
              },
            ),
          ),
          MessageInputField(
            onSubmitted: (value) {
              if (loggedUser == null) {
                return;
              }

              final message = Message(
                from: loggedUser.uid,
                to: targetUser.uid,
                text: value,
              );

              ref.read(chatProvider.notifier).sendMessage(message);
            },
          ),
        ],
      ),
    );
  }
}
