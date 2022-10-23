import 'package:application_20221022/chat_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 화면 전환을 할 때는 클래스를 따로 만들어서 구현

void main() {
  runApp(const MyApp()); // 앱 구동시켜 달라는 의미 // runApp 안에 메인페이지를 입력해줌
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('친구', style: TextStyle(fontWeight: FontWeight.w300, color: Color(
            0xff797979))), // 글자의 두께를 줄임
        actions: [ // 우측에 배치
          IconButton(icon: Icon(Icons.search), onPressed: null), // 검색 아이콘
          IconButton(icon: Icon(Icons.person_add_alt), onPressed: null), // 친구추가 아이콘
          IconButton(icon: Icon(Icons.settings), onPressed: null) // 설정 아이콘
        ],
      ),
      body: Container(
        height: 150, width: double.infinity, // 세로 150, 가로 최대
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
      bottomNavigationBar: BottomAppBar(
        child: Row( // 가로로 정렬
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
          children: [
            IconButton(onPressed: null, icon: Icon(Icons.person_outline)), // 친구목록 아이콘
            IconButton(onPressed: null, icon: Icon(Icons.chat_bubble_outline)), // 채팅목록 아이콘
            IconButton(onPressed: null, icon: Icon(Icons.list_alt)), // 게시글목록 아이콘
            IconButton(onPressed: null, icon: Icon(Icons.segment)) // 전체목록 아이콘
          ],
        ),
      ),
    );
  }
}

