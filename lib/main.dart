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
        appBar: AppBar( ),
        body: Container(
          height: 150,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Image.asset('assets/Camera.jpg', width: 150),
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    Text('카메라 팝니다.'),
                    Text('금호동 3가'),
                    Text('7000원'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // 오른쪽으로 보내주세요.
                      children: [
                        Icon(Icons.favorite),
                        Text('4')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
        )
      );
  }
}