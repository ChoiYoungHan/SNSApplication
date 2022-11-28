import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/my_List.dart';
import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

import 'chatListInfo.dart';
import 'chat_page.dart';

class ChatList_UserEmail{ // 로그인한 유저의 이메일 정보를 받아와 저장할 class 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  ChatList_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class chat_List extends StatelessWidget {
  const chat_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usEmail = ModalRoute.of(context)?.settings.arguments as ChatList_UserEmail; // ChatList_UserEmail 클래스의 인자값을 받아오겠다.

    return MaterialApp(
      routes: {
        '/friendList' : (context) => MyApp(), // MyApp 페이지로 값을 넘겨주기 위한 선언
        '/postList' : (context) => post_List(), // post_List 페이지로 값을 넘겨주기 위한 선언
        '/myList' : (context) => my_List(), // my_List 페이지로 값을 넘겨주기 위함
        '/chatList' : (context) => chat_List(),
        '/chatPage' : (context) => chatMain()
      },
      debugShowCheckedModeBanner: false,
      home: ListViewPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg) // ListViewPage로 로그인한 사용자의 이메일 정보를 보내줌
    );
  }
}

class ListViewPage extends StatefulWidget {
  final userEmail, userName, userStateMsg;

  const ListViewPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  static const routeName = '/chatList'; // 값을 받기 위함

  // 데이터리스트
  static List<String> chatImage = [];
  static List<String> chatName = [];
  static List<String> chatMsg = [];
  static List<String> chatCount = [];
  static List<String> chatTime = [];

  // 읽어들인 각각의 인덱스 값을 저장할 변수
  String Chat_Read_Image = '', Chat_Read_Name = '', Chat_Read_Msg = '', Chat_Read_Count = '', Chat_Read_Time = '';

  // 읽어들인 문자열을 저장할 변수
  String Chat_Read_All = '';

  // 읽어들인 것을 저장할 배열
  static List<String> Chat_Read_Info = [];

  // 구분자로 나누어 각각의 나눈 값을 삽입할 배열
  static List<String> Chat_split_info = [];

  // 채팅방을 추가할 때 검색할 텍스트 필드
  TextEditingController inputFriendName = TextEditingController();

  void initState(){
    getChatInfo();
  }

  void getChatInfo() async {
    // 혹시라도 배열에 값이 들어있는 것을 방지하기 위해 비워줌
    chatImage.clear();
    chatName.clear();
    chatMsg.clear();
    chatCount.clear();
    chatTime.clear();

    // 채팅목록을 검색하기 위한 Url 실행
    final Chat_response =
        await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅방목록.php?user=' + widget.userEmail));

    // 문서... Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(Chat_response.body);

    // setState() 함수 안에서의 호출은 State 에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할이다.
    // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
    setState(() {
      // php 문서에서 className이 chatlist 아래에 있는 정보들을 가져와서 Read_Msg 변수에 저장
      final Read_Msg = document.getElementsByClassName('chatlist');

      // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
      Chat_Read_Info = Read_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

      // Chat_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td> & <br>을 제거함
      Chat_Read_All = Chat_Read_Info[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');

      // Chat_Read_All 의 값을 구분자 '&'로 나누어 배열에 저장함
      Chat_Read_Info = Chat_Read_All.split('&');

      // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
      for(int i = 0; i < Chat_Read_Info.length -1; i++){
        // Chat_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어서 배열에 집어넣음
        Chat_split_info = Chat_Read_Info[i].split('::');

        // 각 배열의 인덱스 값을 문자열에 저장 해줌
        Chat_Read_Image = Chat_split_info[0];
        Chat_Read_Name = Chat_split_info[1];
        Chat_Read_Msg = Chat_split_info[2];
        Chat_Read_Count = Chat_split_info[3];
        Chat_Read_Time = Chat_split_info[4];

        // 문자열을 각자의 배열에 삽입
        chatImage.add(Chat_Read_Image.toString());
        chatName.add(Chat_Read_Name.toString());
        chatMsg.add(Chat_Read_Msg.toString());
        chatCount.add(Chat_Read_Count.toString());
        chatTime.add(Chat_Read_Time.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // List.generate는 length의 길이만큼 0부터 index - 1 까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
    final List<chatListInfo> chatData = List.generate(chatName.length, (index) =>
        chatListInfo(chatImage[index], chatName[index], chatMsg[index], chatCount[index], chatTime[index]));

    return Scaffold( // 상 중 하를 나누는 위젯
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경색은 흰색
        title: Text('채팅방', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff797979))), // 글자의 크기를 줄임
        actions: [ // 상단바의 우측에 정렬
          IconButton( // 아이콘 버튼
              onPressed: null,
              icon: Icon(Icons.search, color: Colors.grey)),
          IconButton(
            onPressed: (){
              showDialog(context: context, builder: (context){
                return Dialog(
                  child: Container(
                    width: 150, height: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Color(0xffC6C8C6),
                              width: 1.5
                            ))
                          ),
                          alignment: Alignment.center,
                          width: double.infinity, height: double.infinity,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: inputFriendName,
                            decoration: InputDecoration(
                              hintText: '친구 아이디를 입력해주세요.',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xffC6C8C6)
                                )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xffC6C8C6)
                                )
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xffC6C8C6)
                                )
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xffC6C8C6)
                                )
                              )
                            )
                          )
                        ), flex: 2),
                        Expanded(child: Container(
                          width: double.infinity, height: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final Friend_add_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅방만들기.php?user1=' + widget.userEmail + '&user2=' + inputFriendName.text));
                              Navigator.pushNamed(context, '/chatPage', arguments: ChatPage_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                            },
                            child: Text('확인')
                          )
                        ), flex: 1)
                      ]
                    )
                  )
                );
              });},
              icon: Icon(Icons.add_circle_outline_outlined, color: Colors.grey)),
          IconButton(
              onPressed: null,
              icon: Icon(Icons.settings, color: Colors.grey)),
        ],
      ),
      body: ListView.builder(
        itemCount: chatName.length, // chatName 배열의 크기만큼 길이를 줌
        itemBuilder: (context, index){
          return GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
            onLongPress: (){ // 길게 누를 시
              showDialog( // 팝업화면을 띄울 것임
                  context: context,
                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                  builder: (context){
                    return Dialog( // Dialog 위젯
                      child: Container( // 상자 위젯
                        width: 150, // 가로 150
                        height: 130, // 높이 130
                        child: Column( // 세로 정렬
                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                          children: [
                            Expanded(child: Container( // 상자 위젯
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide( // Container의 아래 테두리에 색을 줄 것임
                                        color: Color(0xffC6C8C6),
                                        width: 1.5
                                    ))
                                ),
                                alignment: Alignment.center, // 글자가 가운데로 오도록
                                width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                child: Text('채팅방 이름 설정', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체, 크기 16
                            ), flex: 1),
                            Expanded(child: Container( // 상자 위젯
                                alignment: Alignment.center, // 글자가 가운데로 오도록
                                width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                child: Text('방 나가기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체, 크기 16
                            ), flex: 1)
                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            child: Container( // 상자 위젯
              width: double.infinity, // 가로 무제한
              height: 80, // 세로 80
              child: Card( // Card 위젯( 모서리가 둥글다는 특징이 있음 )
                child: Row( // 가로 정렬
                  mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                  children: [
                    Expanded(child: Container( // 상자 위젯
                      width: 100, height: 100, // 가로와 세로 100
                      child: Padding( // 여백을 주기 위해 사용하는 위젯
                        padding: EdgeInsets.all(13), // 모든 면의 여백을 13만큼 줌
                        child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용하는 위젯
                          borderRadius: BorderRadius.circular(45), // 각진 부분을 45만큼 둥글게
                          child: Image.asset(chatData[index].chatImage, width: 100, height: 100, fit: BoxFit.cover) // 사진을 꽉 차게
                        ),
                      ),
                    ), flex: 2),
                    Expanded(child: Container( // 상자 위젯
                      width: 100, height: 100, // 가로와 세로 100
                      child: Column( // 세로 정렬
                        mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                        children: [
                          Expanded(child: Container( // 상자 위젯
                            child: Row( // 가로 정렬
                              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                              children: [
                                Text(chatData[index].chatName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)), // 볼드체 , 크기 15
                                Expanded(
                                  child: Text(chatData[index].chatTime,
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xffC6C8C6)), // 볼드체, 크기 13
                                      textAlign: TextAlign.end // 우측 끝에 정렬
                                  )
                                ),
                                SizedBox(width: 7)
                              ],
                            ),
                          ), flex: 1),
                          Expanded(child: Container( // 상자 위젯
                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                              child: Text(chatData[index].chatMsg, style: TextStyle(color: Color(0xffC6C8C6)))
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
                    Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg)); // 친구 목록 페이지로 이동 및 인자값 전달
                  },
                  icon: Icon(Icons.person_outline)), // 친구목록 아이콘버튼
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.blue)), // 채팅목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg)); // 게시글 목록으로 이동 및 인자값 전달
                  },
                  icon: Icon(Icons.list_alt)), // 게시글목록 아이콘버튼
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/myList', arguments: MyList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));  // 전체 목록으로 이동 및 인자값 전달
                  },
                  icon: Icon(Icons.segment)), // 전체목록 아이콘버튼
            ],
          ),
        ),
      ),
    );
  }
}

