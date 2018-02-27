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
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = new ChatMessage(text: text,);

    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Friendlychat")),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
                color: Theme
                    .of(context)
                    .cardColor), //new
            child: _buildTextComposer(), //modified
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return

      new Theme(data: new ThemeData(accentColor: Colors.green,
          textTheme: new TextTheme(title: new TextStyle(color: Colors.green),
//            body1: new TextStyle(color: Colors.green),
//            body2: new TextStyle(color: Colors.green),
            subhead: new TextStyle(color: Colors.green),

          )),
          child:

          new IconTheme(data:
          new IconThemeData(color: Theme
              .of(context)
              .accentColor),
              child:
              new Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  color: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      new Flexible(
                          child: new TextField(
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            controller: _textController,
                            onSubmitted: _handleSubmitted,
                            decoration: new InputDecoration.collapsed(
                                hintText: "Send a message"),
                          )
                      ),
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                            icon: new Icon(Icons.send,),
                            onPressed: () =>
                                _handleSubmitted(_textController.text)),
                      )
                    ],
                  )

              )
          ));
  }

}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(_name[0])),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme
                  .of(context)
                  .textTheme
                  .subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


const String _name = "John Doe";