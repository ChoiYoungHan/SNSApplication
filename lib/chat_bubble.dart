import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

class Chat_Bubble extends StatelessWidget {
  const Chat_Bubble({Key? key, required this.message, required this.writer, required this.Loginuser, required this.LoginuserName, required this.OtheruserName, required this.View, required this.Time}) : super(key: key);

  final String message, writer, Loginuser, LoginuserName, OtheruserName, View, Time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: writer == Loginuser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if(writer == Loginuser)
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,5,5),
            child: Column(
              crossAxisAlignment: writer == Loginuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Text(LoginuserName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: writer == Loginuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: View == '1' ? Text(View, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)) : null
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Text(Time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey))
                        )
                      ],
                    ),
                    ChatBubble(
                      clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
                      backGroundColor: Colors.blue,
                      margin: EdgeInsets.only(top: 6),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7
                        ),
                        child: Text(
                          message, style: TextStyle(color: Colors.white)
                        )
                      )
                    )
                  ],
                ),
              ],
            ),
          )
        else if (writer != Loginuser)
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
            child: Column(
              crossAxisAlignment: writer == Loginuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(OtheruserName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
                Row(
                  children: [
                    ChatBubble(
                      clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
                      backGroundColor: Colors.blue,
                      margin: EdgeInsets.only(top: 10),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7
                        ),
                        child: Text(
                          message, style: TextStyle(color: Colors.white)
                        )
                      )
                    ),
                    Column(
                      crossAxisAlignment: writer == Loginuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 6),
                          child: View == '1' ? Text(View, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)) : null
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 21, 0, 3),
                          child: Text(Time, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey))
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
      ],
    );
  }
}
