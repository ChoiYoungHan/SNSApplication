import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        appBar: AppBar( title: Text('ddd'), ),
        body: Row(
          children: [
            // 컨테이너 박스 두 개를 넣고 3:7 비율로 할 때 이런식으로 써 넣으면 됨
            Flexible(child: Container(color: Colors.blue), flex: 3), // %를 이용하려면 Flexible로 감싸줘야 한다.
            Flexible(child: Container(color: Colors.green), flex: 7)
          ],
        ),
        )
      );
  }
}