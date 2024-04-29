import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:example/conversations_page.dart';
import 'package:example/custom_video_message/custom_message_page.dart';
import 'package:example/messages_page.dart';
import 'package:flutter/material.dart';

class ChatConfig {
  static const String appKey = '411087907#1268520';
  final String userId;
  final String agoraToken;
  ChatConfig({
    required this.agoraToken,
    required this.userId,
  });
}

final config1 = ChatConfig(
  userId: '644214f881795885c04dc15a',
  agoraToken:
      '007eJxTYFi1tXSDtvbOqDg2zkVb752aVPnH7LvzpJzo9RObJLPOKR5WYDAyMbZMTDRKSktJsjSxNDGwSDFMSTI0MjZIsUhNSTYyX/hDM60hkJHB85g0EyMDKwMjEIL4KgxmacbGZqmmBrppZmbmuoaGqam6FiZmprrGaSmmpgbmFkZGhgYAqEwm+g==',
);
final config2 = ChatConfig(
  userId: '661528aae60a9114f1d5f963',
  agoraToken:
      '007eJxTYDj3MHaV5f/g1e0qYfd2L911Sov94dIl6mWnZGNjBAMymZcqMBiZGFsmJholpaUkWZpYmhhYpBimJBkaGRukWKSmJBuZX/+lmdYQyMjQnbSFlZGBlYERCEF8FYZEy6S0ZANzA900MzNTXUPD1FTdpCRTI11Tc/Pk5NQkQwtj01QA1WoojA==',
);

void main() async {
  assert(ChatConfig.appKey.isNotEmpty,
      "You need to configure AppKey information first.");
  WidgetsFlutterBinding.ensureInitialized();
  final options = ChatOptions(
    appKey: ChatConfig.appKey,
    autoLogin: false,
  );
  await ChatClient.getInstance.init(options);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        // ChatUIKit widget at the top of the widget
        return ChatUIKit(child: child!);
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // empty by default
  ChatConfig config = ChatConfig(agoraToken: '', userId: '');

  ScrollController scrollController = ScrollController();
  ChatConversation? conversation;

  // chat id is just another user id
  final recipientIdController = TextEditingController();

  final List<String> _logText = [];

  void setConfig(ChatConfig config, String recipientId) {
    setState(() {
      this.config = config;
      recipientIdController.text = recipientId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            Text("login userId: ${config.userId}"),
            Text("agoraToken: ${config.agoraToken}"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      setConfig(config1, config2.userId);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text("SET USER 1"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setConfig(config2, config1.userId);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text("SET USER 2"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      _signIn();
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text("SIGN IN"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _signOut();
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    child: const Text("SIGN OUT"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter recipient's userId",
                    ),
                    controller: recipientIdController,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        pushToChatPage(recipientIdController.text);
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                      ),
                      child: const Text("START CHAT"),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        pushToCustomChatPage(recipientIdController.text);
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                      ),
                      child: const Text("CUSTOM CHAT"),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                pushToConversationPage();
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
              child: const Text("CONVERSATION"),
            ),
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (_, index) {
                  return Text(_logText[index]);
                },
                itemCount: _logText.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pushToConversationPage() async {
    if (ChatClient.getInstance.currentUserId == null) {
      _addLogToConsole('user not login');
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ConversationsPage();
    }));
  }

  void pushToChatPage(String userId) async {
    if (userId.isEmpty) {
      _addLogToConsole('UserId is null');
      return;
    }
    if (ChatClient.getInstance.currentUserId == null) {
      _addLogToConsole('user not login');
      return;
    }
    ChatConversation? conv =
        await ChatClient.getInstance.chatManager.getConversation(userId);
    Future(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return MessagesPage(conv!);
      }));
    });
  }

  void pushToCustomChatPage(String userId) async {
    if (userId.isEmpty) {
      _addLogToConsole('UserId is null');
      return;
    }
    if (ChatClient.getInstance.currentUserId == null) {
      _addLogToConsole('user not login');
      return;
    }
    ChatConversation? conv =
        await ChatClient.getInstance.chatManager.getConversation(userId);
    Future(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return CustomMessagesPage(conv!);
      }));
    });
  }

  void _signIn() async {
    _addLogToConsole('begin sign in...');
    if (config.agoraToken.isNotEmpty) {
      try {
        await ChatClient.getInstance.loginWithAgoraToken(
          config.userId,
          config.agoraToken,
        );
        _addLogToConsole('sign in success');
      } on ChatError catch (e) {
        _addLogToConsole('sign in fail: ${e.description}');
      }
    } else {
      _addLogToConsole(
          'sign in fail: The password and agoraToken cannot both be null.');
    }
  }

  void _signOut() async {
    _addLogToConsole('begin sign out...');
    try {
      await ChatClient.getInstance.logout();
      _addLogToConsole('sign out success');
    } on ChatError catch (e) {
      _addLogToConsole('sign out fail: ${e.description}');
    }
  }

  void _addLogToConsole(String log) {
    _logText.add("$_timeString: $log");
    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  String get _timeString {
    return DateTime.now().toString().split(".").first;
  }
}
