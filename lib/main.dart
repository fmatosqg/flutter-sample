import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

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
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ChatScreenState();

}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  bool _isComposing = false;

  void _handleSubmitted(String text) {
    _textController.clear();
    _isComposing = false;

    ChatMessage message = new ChatMessage(text: text,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 300)),);

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Friendly Chat"),
        elevation: Theme
            .of(context)
            .platform == TargetPlatform.iOS ? 0.0 : 4.0,),
      body: new Container(
        child: new Column(
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
                      .cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme
            .of(context)
            .platform == TargetPlatform.iOS
            ? new BoxDecoration(
            border: new Border(top: new BorderSide(color: Colors.grey[200])))
            : null,
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  Widget _buildTextComposer() {
    return
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
                        onChanged: (String text) {
                          setState(() {
                            _isComposing = text.length > 0;
                            print("Is composing  = $_isComposing");
                          });
                        },
                        onSubmitted: _handleSubmitted,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Send a message"),
                      )
                  ),
                  new
                  Container
                    (margin: new EdgeInsets.symmetric (horizontal: 4.0),
                      child: Theme
                          .of(context)
                          .platform == TargetPlatform.iOS
                          ? new CupertinoButton(
                        child: new Text("Send"),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textController.text) //new
                            : null,)
                          : new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: _isComposing ?
                            () => _handleSubmitted(_textController.text) : null,
                      )


                  ),
                ],)
          )
      );
  }

}

class SendButton extends StatelessWidget {

//  SendButton()

  @override
  Widget build(BuildContext context) {
    return
      new IconButton (icon: new Icon (Icons.send,),
          onPressed: null);
  }


}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return
      new SizeTransition(sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Expanded(
                child: new Column(
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
              ),
            ],
          ),),
      );
  }
}


const String _name = "John Doe";

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400]
);