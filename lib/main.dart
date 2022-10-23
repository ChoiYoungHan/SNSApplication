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
    return Scaffold(
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
        height: 100, // 세로 150
        child: Row(
          children: [
            Flexible(child: Padding( // 여백을 주기 위해 사용하는 위젯
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0), // 좌측에 15만큼 여백을 줌
              child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용
                  borderRadius: BorderRadius.circular(55), // 4면을 55만큼 줄여서 둥글게 함
                  child: Image.asset('assets/Camera.jpg', width: 100, height: 100))
            ), flex: 2
            ),
            Flexible(child: Container(
              width: double.infinity, // 길이를 최대로
              padding: EdgeInsets.all(10), // 모든 면의 여백을 10
              child: Column( // 세로
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: Text('이름'), flex: 1),
                  Flexible(child: Text('상태메시지'), flex: 1)
                ],
              ),
            ), flex: 8
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container( // 가로로 정렬
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
            children: [
              IconButton(onPressed: null, icon: Icon(Icons.person_outline)), // 친구목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.chat_bubble_outline)), // 채팅목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.list_alt)), // 게시글목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.segment)) // 전체목록 아이콘
            ],
          ),
        ),
      ),
    );
  }
}