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
      home: Container( width: 50, height: 50, color: Colors.blue) // 박스 위젯을 사용할 때는 Container 혹은 SizedBox 사용 // 컨테이너만 넣으면 투명함
      // 위젯 안에다가 스타일을 주고 싶을때는 소괄호 안에다가 작성하면 됨 // Flutter의 단위는 LP, 50LP = 1.2cm 정도라고 생각하면 됨

    );
  }
}