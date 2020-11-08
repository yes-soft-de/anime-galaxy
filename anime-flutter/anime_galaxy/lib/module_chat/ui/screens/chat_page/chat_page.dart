import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:anime_galaxy/module_chat/model/chat/chat_model.dart';
import 'package:anime_galaxy/module_chat/ui/widget/chat_bubble/chat_bubble.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;

  ChatPage(this._chatPageBloc);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList = [];
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  final TextEditingController _msgController = TextEditingController();
  List<ChatBubbleWidget> chatsMessagesWidgets = [];

  String chatRoomId;

  @override
  Widget build(BuildContext context) {
    chatRoomId = ModalRoute.of(context).settings.arguments.toString();

    if (currentState == ChatPageBloc.STATUS_CODE_INIT) {
      print('Chat Room: ' + chatRoomId);
      widget._chatPageBloc.getMessages(chatRoomId);
    }

    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      print('Got Event');
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length == _chatMessagesList.length) {
        } else {
          buildMessagesList(_chatMessagesList).then((value) {
            if (this.mounted) setState(() {});
          });
        }
      }
    });

    return Scaffold(
      body: Column(
        // direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppBar(
            title: Text(S.of(context).chatRoom),
          ),
          Expanded(
            child: chatsMessagesWidgets != null
                ? ListView(
                    children: chatsMessagesWidgets,
                    reverse: false,
                  )
                : Center(
                    child: Text(S.of(context).loading),
                  ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: S.of(context).startWriting,
                    ),
                    controller: _msgController,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(90))),
                    child: Icon(Icons.send),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<ChatBubbleWidget> newMessagesList = [];
    FirebaseAuth auth = await FirebaseAuth.instance;
    User user = auth.currentUser;
    chatList.forEach((element) {
      print(jsonEncode(element));
      newMessagesList.add(ChatBubbleWidget(
        message: element.msg,
        me: element.sender == user.uid ? true : false,
        sentDate: DateTime.parse(element.sentDate),
      ));
    });
    chatsMessagesWidgets = newMessagesList;
    return;
  }

  void sendMessage() {
    log('Sending: ' + _msgController.text);
    widget._chatPageBloc.sendMessage(chatRoomId, _msgController.text.trim());
    _msgController.clear();
  }
}
