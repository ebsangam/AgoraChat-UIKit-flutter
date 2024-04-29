import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage(this.conversation, {super.key});

  final ChatConversation conversation;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.id),
      ),
      body: SafeArea(
        // Message page in uikit.
        child: ChatMessagesView(
          conversation: widget.conversation,
          avatarBuilder: (context, userId) {
            // you can disable avatar for sender by comparing
            // userId
            // if (isMyself(userId)) return SizedBox();
            return CircleAvatar(
              child: Text(userId.substring(0, 3)),
            );
          },
          enableScrollBar: false,
          // itemBuilder: (context, model) {
          //   return Text(model.message.serverTime.toString());
          // },
          inputBarMoreActionsOnTap: (items) {
            return [
              ChatBottomSheetItem(
                label: 'Custom item',
                type: ChatBottomSheetItemType.normal,
              ),
              ChatBottomSheetItem(
                label: 'Custom destructive item',
                type: ChatBottomSheetItemType.destructive,
              ),
            ];
          },
          messageListViewController:
              ChatMessageListController(widget.conversation),
        ),
      ),
    );
  }
}
