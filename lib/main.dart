import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 앱 구동시켜 달라는 의미 // runApp 안에 메인페이지를 입력해줌
}

// Flutter에서 앱을 만드는 것은 위젯을 짜깁기 하는 것이라 보면 됨.
/*
 # Flutter에는 위젯이 4개가 있다.
 # 글자 위젯, 이미지 위젯, 아이콘 위젯, 박스 위젯
 # 위젯 디자인을 구글 or 커스텀 → MaterialApp, 아이폰 디자인이면 CupertinoApp 하면 됨
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( // Scaffold는 앱을 상 중 하 나눠주는 위젯
        appBar: AppBar( title: Text('어플리케이션')), // 앱의 상단바에 텍스트 위젯을 넣음
        body: SizedBox(
          child: Text('안녕하세요', // Text()는 style: 안에 스타일을 넣을 수 있음
            style: TextStyle( color: Color(0xff000000)), // Hax칼라를 줄때는 Color를 사용하고 앞에 0xff를 써줘야함
          ),
        ),
      ),
    );
  }
}