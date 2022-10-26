import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class my_List extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('My', style: TextStyle(fontWeight: FontWeight.w300, color: Color(
            0xff797979))), // 글자의 두께를 줄임
        actions: [ // 우측에 배치
          IconButton(icon: Icon(Icons.search), onPressed: null), // 검색 아이콘
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        children: [
          profile(), Container(height: 5), list()
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
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => post_List()));
              }, icon: Icon(Icons.list_alt)), // 게시글목록 아이콘
              IconButton(onPressed: null, icon: Icon(Icons.segment, color: Colors.blue)) // 전체목록 아이콘
            ],
          ),
        ),
      ),
    );
  }
}

class profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Row를 이용하여 가로정렬 할 것임
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          width: 1.5,
          color: Color(0xffC6C8C6)
        ))
      ),
      width: double.infinity, height: 100,
      child: Row( // Row 안에는 Container가 2개 들어감
        children: [
          Expanded(child: Container( // Image가 들어갈 영역
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset('assets/sky.jpg', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
              ),
            ),
          ), flex: 3),
          Expanded(child: Container( // Container 2개가 Column을 이용하여 들어갈 것임
            child: Column(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text('이름', style: TextStyle(fontSize: 20, color: Colors.black))
                ), flex: 1),
                Expanded(child: Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text('상태메시지', style: TextStyle(fontSize: 20, color: Colors.black))
                ), flex: 1)
              ],
            ),
          ), flex: 7)
        ],
      ),
    );
  }
}

class list extends StatelessWidget {
  const list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Column을 이용하여 Container 6개를 넣어줄 것임
      width: double.infinity, height: 350,
      child: Column(
        children: [
          Expanded(child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffC6C8C6)
                ))
            ),
            child: Text('프로필 편집', style: TextStyle(fontSize: 16)),
          ), flex: 1),
          Expanded(child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffC6C8C6)
                ))
            ),
            child: Text('차단친구관리', style: TextStyle(fontSize: 16)),
          ), flex: 1),
          Expanded(child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffC6C8C6)
                ))
            ),
            child: Text('통화', style: TextStyle(fontSize: 16)),
          ), flex: 1),
          Expanded(child: Container( // Row를 이용하여
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffC6C8C6)
                ))
            ),
            child: Text('메시지 알림', style: TextStyle(fontSize: 16)),
          ), flex: 1),
          Expanded(child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffC6C8C6)
                ))
            ),
            child: Text('공지사항', style: TextStyle(fontSize: 16)),
          ), flex: 1),
          Expanded(child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffC6C8C6)
                ))
            ),
            child: Text('앱버전', style: TextStyle(fontSize: 16)),
          ), flex: 1),
        ],
      )
    );
  }
}


