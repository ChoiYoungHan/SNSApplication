import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 앱 구동시켜 달라는 의미 // runApp 안에 메인페이지를 입력해줌
}

// Flutter에서 앱을 만드는 것은 위젯을 짜깁기 하는 것이라 보면 됨.
/*
Flutter에는 위젯이 4개가 있다.
글자 위젯, 이미지 위젯, 아이콘 위젯, 박스 위젯
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Icon(Icons.star) // Icon 위젯을 사용할때는 Icon(Icons.아이콘이름)해서 사용, 아이콘의 이름은 flutter 홈페이지에 있어서 찾아쓰면 됨
    );
  }
}
