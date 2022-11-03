import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/my_List.dart';
import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class chat_List extends StatelessWidget {
  const chat_List({Key? key}) : super(key: key);

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

  // 데이터리스트
  static List<String> roomImagePath = [
    'assets/Ahnhyunsoo.png',
    'assets/Choihojin.png',
    'assets/Choiyounghan.png',
    'assets/Hwangsoohyun.png',
    'assets/Kimwon.png',
    'assets/Kimyongsoo.png',
    'assets/Leeeunsoo.png',
    'assets/Parkminki.png',
    'assets/Shinsangwoo.png',
    'assets/Yujin.png'
  ];
  static List<String> roomName = ['Ahnhyunsoo', 'Choihojin', 'Choiyounghan', 'Hwangsoohyun', 'Kimwon', 'Kimyongsoo', 'Leeeunsoo', 'Parkminki','Shinsangwoo', 'Yujin'];
  static List<String> roomPersonnel = ['2', '2', '2', '2', '2', '2', '2', '2', '2', '2'];
  static List<String> chatTime = ['23:20', '22:13', '22:10', '19:33', '15:33', '1일전', '1일전', '1일전', '3일전', '3일전'];
  static List<String> chatMsg = [
    '오늘 날씨 좋다',
    '매우편안',
    '시험공부',
    '귀여운 호두',
    '틀린말은 아니지',
    'so cool',
    '꿈을 위하여',
    '귀요미',
    'Weekend',
    '빵야'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('채팅방', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff797979))),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: null,
              icon: Icon(Icons.add_circle_outline_outlined)),
          IconButton(
              onPressed: null,
              icon: Icon(Icons.settings)),
        ],
      ),
      body: ListView.builder(
        itemCount: roomImagePath.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onLongPress: (){
              showDialog( // 팝업화면을 띄울 것임
                  context: context,
                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                  builder: (context){
                    return Dialog(
                      child: Container(
                        width: 150,
                        height: 130,
                        child: Column(
                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                          children: [
                            Expanded(child: Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide( // Container의 아래 테두리에 색을 줄 것임
                                        color: Color(0xffC6C8C6),
                                        width: 1.5
                                    ))
                                ),
                                alignment: Alignment.center, // 글자가 가운데로 오도록
                                width: double.infinity, height: double.infinity,
                                child: Text('채팅방 이름 설정', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                            ), flex: 1),
                            Expanded(child: Container(
                                alignment: Alignment.center, // 글자가 가운데로 오도록
                                width: double.infinity, height: double.infinity,
                                child: Text('방 나가기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                            ), flex: 1)
                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            child: Container(
              width: double.infinity,
              height: 80,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Container(
                      width: 100, height: 100,
                      child: Padding(
                        padding: EdgeInsets.all(13),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image.asset(roomImagePath[index], width: 100, height: 100, fit: BoxFit.cover)
                        ),
                      ),
                    ), flex: 2),
                    Expanded(child: Container(
                      width: 100, height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(roomName[index], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text(roomPersonnel[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffC6C8C6))),
                                Icon(Icons.notifications_off, color: Color(0xffC6C8C6), size: 13),
                                Expanded(
                                  child: Text(chatTime[index],
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xffC6C8C6)),
                                      textAlign: TextAlign.end
                                  )
                                ),
                                SizedBox(width: 7)
                              ],
                            ),
                          ), flex: 1),
                          Expanded(child: Container(
                              width: double.infinity, height: double.infinity,
                              child: Text(chatMsg[index], style: TextStyle(color: Color(0xffC6C8C6)))
                          ), flex: 1)
                        ],
                      ),
                    ), flex: 8)
                  ],
                ),
              ),
            ),
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
                  onPressed: null,
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.blue)), // 채팅목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => post_List(), // 즉시 이동을 하고 싶을때는 PageRouteBuilder 사용
                        transitionDuration: Duration.zero, // 속도 0
                        reverseTransitionDuration: Duration.zero // 속도 0
                    ));// 게시글 목록으로 이동
                  },
                  icon: Icon(Icons.list_alt)), // 게시글목록 아이콘버튼
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
      ),
    );
  }
}

