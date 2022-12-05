import 'dart:async';

import 'package:application_20221022/blackListFile.dart';
import 'package:application_20221022/my_List.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class BlackList_UserEmail { // 로그인한 사용자의 정보를 담아둘 클래스 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  BlackList_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class black_List extends StatelessWidget {
  const black_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlackList_UserEmail 클래스의 인자값을 받아오기 위함
    final usEmail = ModalRoute.of(context)?.settings.arguments as BlackList_UserEmail;

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/blackList' : (context) => black_List(), // black_List 페이지로 값을 넘겨주기 위한 선언
        '/myList' : (context) => my_List(), // my_List 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: blackListPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMSg: usEmail.userStateMsg)
    );
  }
}

class blackListPage extends StatefulWidget {
  const blackListPage({Key? key, this.userEmail, this.userName, this.userStateMSg}) : super(key: key);

  final userEmail, userName, userStateMSg;
  @override
  State<blackListPage> createState() => _blackListPageState();
}

class _blackListPageState extends State<blackListPage> {

  late Timer timer;

  // 데이터리스트
  static List<String> Black_userUID = [];
  static List<String> Black_userEmail = [];
  static List<String> Black_userName = [];

  // 받아온 정보를 각각의 문자열에 저장한 다음 위의 배열에 넣을 것임
  String Black_Read_UID = '', Black_Read_Email = '', Black_Read_Name = '';

  // 받아온 문자열 전체를 저장할 변수
  String Black_Read_All = '';

  // 읽어온 정보를 담아둘 배열과 각각의 유저 정보를 나눠서 담을 배열
  var Black_Read_Info = <String>[];
  var Black_Split_Info = <String>[];

  void initState(){
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      getBlackInfo();
    });
  }

  void dispose(){
    timer.cancel();
  }

  void getBlackInfo() async {

    // 기존의 배열에 아무것도 들어있지 않게 비워줌
    Black_userUID.clear();
    Black_userEmail.clear();
    Black_userName.clear();

    // 블랙리스트를 검색하기 위한 Url 실행
    final Black_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/차단목록.php?user1=' + widget.userEmail));

    // 문서... Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(Black_response.body);

    // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할
    // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
    setState(() {
      // php 문서에서 className이 blacklist 아래에 있는 정보들을 가져와서 Black_Read_Msg 변수에 저장
      final Black_Read_Msg = document.getElementsByClassName('blacklist');

      // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
      Black_Read_Info = Black_Read_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

      // Black_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td>를 제거함
      Black_Read_All = Black_Read_Info[0].replaceAll(RegExp('(<td>|</td>)'), '');

      // Black_Read_All 의 값을 구분자 '///'로 나누어 배열에 저장함
      Black_Read_Info = Black_Read_All.split('///');

      // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
      for(int i = 0; i < Black_Read_Info.length -1; i++){
        // Black_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어 배열에 집어 넣음
        Black_Split_Info = Black_Read_Info[i].split('::');

        // 각 배열의 인덱스 값을 문자열에 저장
        Black_Read_UID = Black_Split_Info[0];
        Black_Read_Email = Black_Split_Info[1];
        Black_Read_Name = Black_Split_Info[2];

        // 문자열을 각자의 배열에 삽입
        Black_userUID.add(Black_Read_UID.toString());
        Black_userEmail.add(Black_Read_Email.toString());
        Black_userName.add(Black_Read_Name.toString());
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    // List.generate는 length의 길이만큼 0부터 index - 1 까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
    final List<blackListFile> blackData = List.generate(Black_userEmail.length, (index) =>
      blackListFile(BlackuserUID: Black_userUID[index], BlackuserEmail: Black_userEmail[index], BlackuserName: Black_userName[index]));

    return Scaffold( // 상 중 하로 나누는 위젯
      resizeToAvoidBottomInset: false, // 화면 밀림 방지
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 상단바 배경색은 흰색
        leading: IconButton( // 아이콘 버튼 위젯
          onPressed: (){ // 버튼을 누르면 my_List 화면으로 넘어갈 것임
            Navigator.pushNamed(context, '/myList', arguments: MyList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMSg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 아이콘, 색상은 회색
        ),
        title: Text('차단친구 관리', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)) // 볼드체, 색상은 회색
      ),
      body: Container(
        child: ListView.builder(
          itemCount: Black_userEmail.length, // 배열의 길이만큼 리스트뷰 출력
          itemBuilder: (context, index){
            return GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
              child: Container( // 상자 위젯
                width: double.infinity, height: 60, // 가로는 무제한 세로 50
                child: Card( // Card 위젯 ( 모서리가 둥글다는 특징이 있음 )
                  child: Row(
                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                    children: [
                      Container( // 상자 위젯
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼쪽의 10만큼 여백을 줌
                        child: Text(blackData[index].BlackuserName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))), // 볼드체, 크기 16
                      Expanded(child: Container( // 상자 위젯
                        alignment: Alignment.centerRight, // 우측에 정렬
                        height: 30, // 높이 30
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0), // 우측에 10만큼 여백을 줌
                        child: ElevatedButton( // 버튼 위젯
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green), // 버튼 배경색 초록
                          onPressed: (){
                            showDialog(context: context, builder: (context){
                              return Dialog( // Dialog 위젯
                                child: Container( // 상자 위젯
                                  width: 150, height: 150, // 가로와 세로 150
                                  child: Column( // 세로 정렬
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container( // 상자 위젯
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        alignment: Alignment.center, // 가운데 정렬
                                        child: Text('친구 차단을 해제하시겠습니까?', style: TextStyle(fontWeight: FontWeight.bold)) // 볼드체
                                      ), flex: 7),
                                      Expanded(child: Container( // 상자 위젯
                                        child: Row( // 가로 정렬
                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                          children: [
                                            Expanded(child: Container( // 상자 위젯
                                              padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                              child: ElevatedButton( // 버튼 위젯
                                                onPressed: (){
                                                  Navigator.pop(context); // 팝업창 닫음
                                                },
                                                child: Text('취소')
                                              ),
                                            ), flex: 1),
                                            Expanded(child: Container( // 상자 위젯
                                              padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                              child: ElevatedButton( // 버튼 위젯
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  // 차단해제를 하기 위한 Url 실행
                                                  await http.get(Uri.parse('http://www.teamtoktok.kro.kr/차단목록.php?user1=' + widget.userEmail + '&user2=' + blackData[index].BlackuserEmail));

                                                  print('http://www.teamtoktok.kro.kr/차단목록.php?user1=' + widget.userEmail + '&user2=' + blackData[index].BlackuserEmail);

                                                  showDialog(context: context, builder: (context){
                                                    return Dialog( // Dialog 위젯
                                                      child: Container( // 상자 위젯
                                                        width: 150, height: 130, // 가로 150, 세로 130
                                                        child: Column( // 세로 정렬
                                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                          children: [
                                                            Expanded(child: Container( // 상자 위젯
                                                              alignment: Alignment.center, // 가운데 정렬
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Text(blackData[index].BlackuserName + '님을 차단해제 하였습니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체, 크기 16
                                                            ), flex: 2),
                                                            Expanded(child: Container( // 상자 위젯
                                                              padding: EdgeInsets.all(10), // 모든 면의 여백을 10만큼 줌
                                                              child: ElevatedButton( // 버튼 위젯
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Text('확인')
                                                              )
                                                            ), flex: 1)
                                                          ]
                                                        )
                                                      )
                                                    );
                                                  });
                                                },
                                                child: Text('확인')
                                              ),
                                            ), flex: 1)
                                          ]
                                        )
                                      ), flex: 3)
                                    ]
                                  )
                                )
                              );
                            });
                          },
                          child: Text('차단해제', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 13)) // 볼드체, 크기 13, 색상 노랑
                        )
                      ))
                    ]
                  )
                )
              )
            );
          }
        ),
      )
    );
  }
}
