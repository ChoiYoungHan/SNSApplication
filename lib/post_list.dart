import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class post_List extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('게시글', style: TextStyle(fontWeight: FontWeight.w300, color: Color(
            0xff797979))), // 글자의 두께를 줄임
        actions: [ // 우측에 배치
          IconButton(icon: Icon(Icons.search), onPressed: null), // 검색 아이콘
          IconButton(icon: Icon(Icons.add_circle_outline_outlined), onPressed: null), // 게시글 추가 아이콘
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        children: [
          postlist_screen(),Container(height: 10),
          postlist_screen()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }, icon: Icon(Icons.person_outline)), // 친구목록 아이콘
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => chat_List()));
              }, icon: Icon(Icons.chat_bubble_outline)), // 채팅목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.list_alt, color: Colors.blue)), // 게시글목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.segment)) // 전체목록 아이콘
            ],
          ),
        ),
      ),
    );
  }
}

class  postlist_screen extends StatelessWidget {
  const postlist_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // 박스
      width: double.infinity,
      height: 400, // 높이 400
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Color(0xffC6C8C6)
        )
      ),
      child: Column( // 세로로 정렬
        children: [ // Container 3개 줄 것임
          Expanded(child: Container(
            width: double.infinity, height: 40,
            child: Row( // 가로로 정렬 Container 2개 줄 것임
              children: [
                Expanded(child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Image.asset('assets/sky.jpg', width: 100, height: 100, fit: BoxFit.cover),
                    ),
                  )
                ), flex: 2),
                Expanded(child: Container(
                  child: Column( // Container 2개가 들어갈 것임
                    children: [
                      Expanded(child: Container(
                        child: Row( // Text와 Icon 2개가 들어갈 것임
                          children: [
                            Expanded(child: Container(
                              child: Text('최영한', style: TextStyle(fontSize: 16)),
                            ), flex: 2),
                            Expanded(child: Container(
                              alignment: Alignment.centerRight,
                              child: Row( // 가로로 Icon 2개 넣어줄 것임
                                children: [
                                  IconButton(onPressed: null, icon: Icon(Icons.more_horiz, color: Color(0xffC6C8C6))),
                                  IconButton(onPressed: null, icon: Icon(Icons.close, color: Color(0xffC6C8C6)))
                                ],
                              ),
                            ), flex: 8)
                          ],
                        ),
                      ), flex: 1),
                      Expanded(child: Container(
                        child: Text('3시간 전', style: TextStyle(fontSize: 13)),
                      ), flex: 1)
                    ],
                  ),
                ), flex: 8)
              ],
            ),
          ), flex: 1),
          Expanded(child: Container(
            width: double.infinity, height: 80,
            child: Text('텍스트가 출력될 영역'),
          ), flex: 2),
          Expanded(child: Container(
            width: double.infinity, height: 280,
            child: Image.asset('assets/sky.jpg', width: 100, height: 100, fit: BoxFit.cover), // 사진으로 화면을 꽉 채움
          ), flex: 7)
        ],
      ),
    );
  }
}
