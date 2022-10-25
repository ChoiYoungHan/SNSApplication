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
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          post_List(), post_List()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container( // 가로로 정렬
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
    return Container(
      width: double.infinity,
      height: 400, // 높이 400
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          color: Color(0xffC6C8C6),
          width: 1.5
        ))
      ),
      child: Column(
        children: [
          Expanded(child: Row( // Container가 2개 들어갈 것임
            children: [
              Expanded(child: Container( // Image가 들어감
                width: 100, height: 100,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.asset('assets/sky.jpg', width: 100, height: 100, fit: BoxFit.cover),
                  ),
                ),
              ), flex: 2),
              Expanded(child: Container( // Column이 들어감
                child: Column( // Row와 Container가 들어감
                  children: [
                    Expanded(child: Row( // Text, Icon, Icon 들어감
                      children: [
                        Expanded(child: Text('최영한')),
                        Expanded(child: Icon(Icons.more_horiz)),
                        Expanded(child: Icon(Icons.close))
                      ],
                    ), flex: 1),
                    Expanded(child: Container( // Text가 들어감
                      child: Text('3시간 전', style: TextStyle(color: Color(0xffC6C8C6), fontSize: 10)),
                    ), flex: 1)
                  ],
                ),
              ), flex: 8)
            ],
          ), flex: 1),
          Expanded(child: Container( // Text가 들어갈 것임
            width: double.infinity, height: double.infinity,
            padding: EdgeInsets.all(5),
            child: Text('텍스트가 들어갈 영역입니다.', style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
          ), flex: 2),
          Expanded(child: Container( // Padding과 ClipRrect가 들어갈 것임
            width: double.infinity, height: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Image.asset('assets/sky.jpg', width: 100, height: 100, fit: BoxFit.cover)
            ),
          ), flex: 7)
        ],
      ),
    );
  }
}
