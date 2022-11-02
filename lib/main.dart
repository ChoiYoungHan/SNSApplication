import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/friend_profilescreen.dart';
import 'package:application_20221022/my_List.dart';
import 'package:application_20221022/post_list.dart';
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

  // 데이터 리스트
  var friendList = ['Ahnhyunsoo', 'Choihojin', 'Choiyounghan', 'Hwangsoohyun', 'Kimwon', 'Kimyongsoo', 'Leeeunsoo', 'Parkminki','Shinsangwoo', 'Yujin'];
  var imagePath = [
    'assets/Ahnhyunsoo.png',
    'assets/Choihojin.png',
    'assets/Choiyounghan.png',
    'assets/Hwangsoohyun.png',
    'assets/Kimwon.png',
    'assets/Kimyongsoo.png',
    'assets/Leeeunsoo.png',
    'assets/Parkminki.png',
    'assets/Shinsangwoo.png',
    'assets/Yujin.png',
  ];
  var stateMsg = [
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
    return Scaffold( // 상 중 하로 나눌때는 Scaffold 위젯을 사용
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경은 흰색
        title: Text('친구', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff797979))), // 상단바에 텍스트로 '친구' 출력, 글자의 두께를 줄임
        actions: [ // 상단바의 우측에 배치
          IconButton(
              onPressed: null,
              icon: Icon(Icons.search)), // 검색 아이콘 버튼
          IconButton(
              onPressed: null,
              icon: Icon(Icons.person_add_alt)), // 친구 추가 아이콘 버튼
          IconButton(
              onPressed: null,
              icon: Icon(Icons.settings)), // 설정 아이콘 버튼
        ],
      ),
      body: ListView.builder( // ListView
          itemCount: friendList.length, // List의 개수는 friendList의 개수만큼
          itemBuilder: (context, index){
            return GestureDetector( // 제스처를 사용할 때 사용하는 위젯
              onLongPress: (){
                showDialog( // 팝업화면을 띄울 것임
                  context: context,
                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                  builder: (context){
                    return Dialog( 
                      child: Container(
                        width: 150,
                        height: 200,
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
                              child: Text('즐겨찾기 추가', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                            ), flex: 1),
                            Expanded(child: Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide( // Container의 아래 테두리에 색을 줄 것임
                                        color: Color(0xffC6C8C6),
                                        width: 1.5
                                    ))
                                ),
                                alignment: Alignment.center, // 글자가 가운데로 오도록
                                width: double.infinity, height: double.infinity,
                                child: Text('이름 변경', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                            ), flex: 1),
                            Expanded(child: Container(
                                alignment: Alignment.center, // 글자가 가운데로 오도록
                                width: double.infinity, height: double.infinity,
                                child: Text('차단', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                            ), flex: 1)
                          ],
                        ),
                      ),
                    );
                  }
                );
              },
              child: Card( // Card 위젯 ( 모서리가 둥글다는 특징이 있음 )
                child: Row( // 가로 정렬
                  mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                  children: [
                    Expanded(child: Container(
                      child: Container(
                        width: 100, height: 100,
                        child: Padding( // 여백을 줄때 사용하는 위젯
                          padding: EdgeInsets.all(10), // 모든 면의 여백을 10
                          child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용
                            borderRadius: BorderRadius.circular(35), // 각진 부분을 45만큼 둥글게 줄임
                            child: Image.asset(imagePath[index], width: 100, height: 100, fit: BoxFit.cover)
                          ),
                        ),
                      ),
                    ), flex: 3),
                    Expanded(child: Container(
                      width: 100, height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                        children: [
                          Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                            padding: EdgeInsets.fromLTRB(5, 20, 5, 5), // 좌 5 위 20 우 5 하 5의 여백을 줌
                            child: Container(
                              width: double.infinity, height: double.infinity,
                              child: Text(friendList[index],
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1),
                            ),
                          ), flex: 1),
                          Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                            padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                            child: Container(
                              width: double.infinity, height: double.infinity,
                              child: Text(stateMsg[index],
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey), maxLines: 1),
                            ),
                          ), flex: 1)
                        ],
                      ),
                    ), flex: 8)
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: BottomAppBar( // 하단바
        child: Container(
          height: 60,
          child: Row( // 가로로 정렬
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
            children: [
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.person_outline, color: Colors.blue)), // 친구목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => chat_List())); // 채팅 목록으로 이동
                  },
                  icon: Icon(Icons.chat_bubble_outline)), // 채팅목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => post_List())); // 게시글 목록으로 이동
                  },
                  icon: Icon(Icons.list_alt)), // 게시글목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => my_List())); // 전체 목록으로 이동
                  },
                  icon: Icon(Icons.segment)), // 전체목록 아이콘버튼
            ],
          ),
        ),
      ),
    );
  }
}

