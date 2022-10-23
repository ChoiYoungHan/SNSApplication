import 'package:flutter/material.dart';

class chat_List extends StatelessWidget {
  const chat_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('채팅 리스트가 출력될 화면입니다.'),
        ),

      ),
    );
  }
}
