import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class chat_List extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('채팅방', style: TextStyle(fontWeight: FontWeight.w300, color: Color(
            0xff797979))), // 글자의 두께를 줄임
        actions: [ // 우측에 배치
          IconButton(icon: Icon(Icons.search), onPressed: null), // 검색 아이콘
          IconButton(icon: Icon(Icons.add_circle_outline_outlined), onPressed: null), // 채팅방 추가 아이콘
          IconButton(icon: Icon(Icons.settings), onPressed: null) // 설정 아이콘
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
          List_Screen(),
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
              IconButton(onPressed: null, icon: Icon(Icons.chat_bubble_outline, color: Colors.blue)), // 채팅목록 아이콘
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => post_List()));
              }, icon: Icon(Icons.list_alt)), // 게시글목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.segment)) // 전체목록 아이콘
            ],
          ),
        ),
      ),
    );
  }
}

class List_Screen extends StatelessWidget {
  const List_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // 높이 80
      decoration: BoxDecoration( // 박스 꾸미기 위한 위젯
        border: Border(bottom: BorderSide( // 아래 테두리를 줄것임
          color: Color(0xffC6C8C6),
          width: 1.5
        ))
      ),
      child: Row( // 가로로 Container와 Column을 줄 것임
        children: [
          Flexible(child: Container( // 채팅방 사진이 들어갈 박스
            width: double.infinity, height: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(13), // 네 면을 13만큼의 여백을 줌
              child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용
                borderRadius: BorderRadius.circular(45), //  네 면을 45만큼 줄임
                child: Image.asset('assets/sky.jpg', width: 100, height: 100, fit: BoxFit.cover), // BoxFit.cover: 지정한 영역을 꽉 채운다.
              ),
            ),
          ), flex: 2),
          Flexible(child: Container(
            width: double.infinity, height: double.infinity, // 가로 세로 비율을 최대로
            padding: EdgeInsets.all(10), // 네 면의 여백을 10
            child: Column( // 세로로 Row와 Text를 줄 것임
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: Container(
                  width: double.infinity, height: double.infinity,
                  child: Row( // Text 2개, 아이콘 1개, 텍스트 1개 배치
                    children: [
                      Text('채팅방 이름', style: TextStyle(fontSize: 18)),
                      Text('3', style: TextStyle(color: Color(0xffC6C8C6))),
                      Icon(Icons.notifications_off, size: 13, color: Color(0xffC6C8C6)),
                      SizedBox(width: 160),
                      Expanded(child: Text('08:30', // Expanded는 부모의 남은 부분을 전부 채우는 식으로 사용
                          textAlign: TextAlign.end, // 우측끝으로
                          style: TextStyle(color: Color(0xffC6C8C6))))
                    ],
                  ),
                ), flex: 1),
                Flexible(child: Text('채팅방 마지막 메시지'), flex: 1),
              ],
            ),
          ), flex: 8)
        ],
      ),
    );
  }
}
