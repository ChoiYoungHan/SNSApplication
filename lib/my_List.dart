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

class  profile extends StatelessWidget {
  const profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column( // Container가 2개 들어갈 것임
        children: [
          Expanded(child: Container(
            child: Row( // 가로로 Container 2개가 들어갈 것임
              children: [
                Expanded(child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Image.asset('assets/sky.jpg', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                    ),
                  ),
                ), flex: 3),
                Expanded(child: Container(
                  child: Column( // Container가 2개 들어갈 것임
                    children: [
                      Expanded(child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('이름', style: TextStyle(fontSize: 20, color: Colors.black)),
                      ), flex: 1),
                      Expanded(child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('상태메시지', style: TextStyle(fontSize: 20, color: Colors.black)),
                      ), flex: 1)
                    ],
                  ),
                ), flex: 7)
              ],
            ),
          ), flex: 3),
          Expanded(child: Container(

          ), flex: 7)
        ],
      )
    );
  }
}

class list extends StatelessWidget {
  const list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
