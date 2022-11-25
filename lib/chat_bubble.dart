import 'package:flutter/material.dart';

class Chat_Bubble extends StatelessWidget {
  const Chat_Bubble({Key? key}) : super(key: key);

  final String message = '안녕';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( // 박스 꾸미기
        color: Colors.blue, // 색상은 파랑
        borderRadius: BorderRadius.circular(12) // 네 모서리를 12줄임
      ),
      width: 145, // 가로 145
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), // EdgeInsets.symmetric는 대칭적인이라는 의미로 수평, 수직을 기준으로 여백지정이 가능하다.
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // EdgeInsets.symmetric는 대칭적인이라는 의미로 수평, 수직을 기준으로 여백지정이 가능하다.
      child: Text(message, style: TextStyle(color: Colors.white)), // 사용자가 입력한 텍스트가 들어갈 위젯
    );
  }
}
