import 'package:flutter/material.dart';

void main() {
  runApp(new FriendlyChatApp());
}

class FriendlyChatApp extends StatelessWidget {
  FriendlyChatApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App title',
      debugShowCheckedModeBanner: false,
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ChatScreenState();

}

class ChatScreenState extends State<ChatScreen> {

  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('ChatState app bar')),
      body: _buildTextComposer(),
    );
  }

  Widget _buildTextComposer() {
    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new TextField(
          controller: _textController,
          onSubmitted: _handleSubmitted,
          decoration: new InputDecoration.collapsed(hintText: "Send a message"),
        )
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
  }
}

