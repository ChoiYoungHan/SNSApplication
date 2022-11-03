import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_List.dart';

class post_List extends StatelessWidget {
  const post_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListViewPage()
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  var friendImage = ['assets/Ahnhyunsoo.png', 'assets/Choihojin.png', 'assets/Kimwon.png'];
  var friendName = ['Ahnhyunsoo', 'Choihojin', 'Kimwon'];
  var postTime = ['1분전', '1시간 전', '1일 전'];
  var postContents = ['밤하늘 보러가실 분~', '안녕하세요.', '깃허브 봐바'];
  var postImage = ['assets/sky.jpg', 'assets/Camera.jpg', 'assets/Github_Image.jpg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('게시글', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff797979))),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(onPressed: null, icon: Icon(Icons.add_circle_outline_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: postContents.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: (){},
            child: Container(
              width: double.infinity, height: 450,
              padding: EdgeInsets.all(5),
              child: Card(
               child: Column(
                 mainAxisSize: MainAxisSize.max,
                 children: [
                   Expanded(child: Container(
                     width: double.infinity, height: double.infinity,
                       decoration: BoxDecoration(
                           border: Border(bottom: BorderSide(
                               width: 1.5,
                               color: Color(0xffC6C8C6)
                           ))
                       ),
                     child: Row(
                       mainAxisSize: MainAxisSize.max,
                       children: [
                         Expanded(child: Container(
                           width: double.infinity, height: double.infinity,
                           child: Padding(
                             padding: EdgeInsets.all(3),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(35),
                               child: Image.asset(friendImage[index], width: 100, height: 100, fit: BoxFit.cover)
                             )
                           )
                         ), flex: 2),
                         Expanded(child: Container(
                           width: double.infinity, height: double.infinity,
                           child: Column(
                             mainAxisSize: MainAxisSize.max,
                             children: [
                               Expanded(child: Container(
                                 width: double.infinity, height: double.infinity,
                                 child: Row(
                                   mainAxisSize: MainAxisSize.max,
                                   children: [
                                     Expanded(child: Container(
                                       width: double.infinity, height: double.infinity,
                                       padding: EdgeInsets.fromLTRB(3, 6, 0, 0),
                                       child: Text(friendName[index]),
                                     ), flex: 3),
                                     Expanded(child: Container(
                                       width: double.infinity, height: double.infinity,
                                       padding: EdgeInsets.fromLTRB(0, 6, 3, 0),
                                       child: Row(
                                         mainAxisSize: MainAxisSize.max,
                                         mainAxisAlignment: MainAxisAlignment.end,
                                         children: [
                                           Icon(Icons.more_horiz, color: Color(0xffC6C8C6)),
                                           Padding(
                                             padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                             child: Icon(Icons.close, color: Color(0xffC6C8C6))
                                           )
                                         ],
                                       )
                                     ), flex: 8)
                                   ],
                                 )
                               ), flex: 1),
                               Expanded(child: Container(
                                 width: double.infinity, height: double.infinity,
                                 padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                 child: Text(postTime[index], style: TextStyle(color: Color(0xffC6C8C6)))
                               ), flex: 1)
                             ]
                           )
                         ), flex: 11)
                       ]
                     )
                   ), flex: 1),
                   Expanded(child: Container(
                     width: double.infinity, height: double.infinity,
                     padding: EdgeInsets.all(10),
                     child: Text(postContents[index], maxLines: 3),
                   ), flex: 2),
                   Expanded(child: Container(
                     width: double.infinity, height: double.infinity,
                     child: Image.asset(postImage[index], width: 100, height: 100, fit: BoxFit.cover),
                   ), flex: 5)
                 ],
               )
              )
            )
          );
        }
      ),
      bottomNavigationBar: BottomAppBar( // 하단바
        child: Container(
          height: 60,
          child: Row( // 가로로 정렬
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => MyApp(), // 즉시 이동을 하고 싶을때는 PageRouteBuilder 사용
                        transitionDuration: Duration.zero, // 속도 0
                        reverseTransitionDuration: Duration.zero // 속도 0
                    )); // 친구 목록으로 이동
                  },
                  icon: Icon(Icons.person_outline)), // 친구목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => chat_List(), // 즉시 이동을 하고 싶을때는 PageRouteBuilder 사용
                        transitionDuration: Duration.zero, // 속도 0
                        reverseTransitionDuration: Duration.zero // 속도 0
                    )); // 채팅 목록으로 이동
                  },
                  icon: Icon(Icons.chat_bubble_outline)), // 채팅목록 아이콘버튼
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.list_alt, color: Colors.blue)), // 게시글목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => my_List(), // 즉시 이동을 하고 싶을때는 PageRouteBuilder 사용
                        transitionDuration: Duration.zero, // 속도 0
                        reverseTransitionDuration: Duration.zero // 속도 0
                    )); // 전체 목록으로 이동
                  },
                  icon: Icon(Icons.segment)), // 전체목록 아이콘버튼
            ],
          ),
        ),
      )
    );
  }
}

