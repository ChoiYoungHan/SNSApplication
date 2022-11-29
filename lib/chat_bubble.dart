import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class Chat_Bubble extends StatelessWidget {
  const Chat_Bubble({Key? key, required this.message, required this.writer, required this.Loginuser, required this.Otheruser}) : super(key: key);

  final String message, writer, Loginuser, Otheruser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: writer == Loginuser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration( // 박스 꾸미기
            color: Colors.blue, // 색상은 파랑
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: writer == Loginuser ? Radius.circular(0) : Radius.circular(12),
              bottomLeft: writer == Loginuser ? Radius.circular(12) : Radius.circular(0)
            )
          ),
          width: 145, // 가로 145
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), // EdgeInsets.symmetric는 대칭적인이라는 의미로 수평, 수직을 기준으로 여백지정이 가능하다.
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // EdgeInsets.symmetric는 대칭적인이라는 의미로 수평, 수직을 기준으로 여백지정이 가능하다.
          child: Text(message, style: TextStyle(color: Colors.white)), // 사용자가 입력한 텍스트가 들어갈 위젯
        ),
      ],
    );
  }
}
