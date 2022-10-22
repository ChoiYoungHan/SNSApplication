import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp()); // 앱 구동시켜 달라는 의미 // runApp 안에 메인페이지를 입력해줌
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debug 없애기
      debugShowCheckedModeBanner: false,
      home: Scaffold( // Scaffold는 앱을 상 중 하 나눠주는 위젯
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null) , // 좌측에 배치
          title: TextButton(onPressed: null, child: Text('어플리케이션')),
          actions: [ // 우측에 배치
            IconButton(icon: Icon(Icons.search), onPressed: null), // 검색 아이콘
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: null), // 장바구니 아이콘
            IconButton(icon: Icon(Icons.notifications), onPressed: null) // 알림(종) 아이콘
          ],
        ),
        body: Container(
          height: 150, // 세로 150
          padding: EdgeInsets.all(20), // 여백 20
          child: Row( // 가로 배치
            children: [
              Flexible(child: Image.asset('assets/Camera.jpg', width: 150), flex: 3), // 사진불러오는 것 비율은 3
              Flexible(child: Container(
                width: double.infinity, // 가로길이를 최대로
                padding: EdgeInsets.all(10), // 여백 10
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽정렬
                  children: [
                    Flexible(child: Text('카메라 팝니다'), flex: 1),
                    Flexible(child: Text('금호동 3가'), flex: 1),
                    Flexible(child: Text('7000원'), flex: 1),
                    Flexible(child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite),
                        Text('4')
                      ],
                    ), flex: 1)
                  ],
                ),
              ), flex: 7)
            ],
          ),
        ),
      )
    );
  }
}