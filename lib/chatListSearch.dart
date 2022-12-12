import 'package:application_20221022/chatListInfo.dart';
import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;


class ChatSearch_UserEmail{ // 로그인한 사용자의 이메일 정보를 담아둘 클래스 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  ChatSearch_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class ChatListSearch extends StatelessWidget {
  const ChatListSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ChatSearch_UserEmail 클래스의 인자값을 받아오기 위함
    final usEmail = ModalRoute.of(context)?.settings.arguments as ChatSearch_UserEmail;

    return MaterialApp(
      routes: {
        '/chatList' : (context) => chat_List(), // chat_List 페이지로 값을 넘겨주기 위한 선언
        '/chatPage' : (context) => chatMain() // chatMain 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: ChatListSearchPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class ChatListSearchPage extends StatefulWidget {
  const ChatListSearchPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<ChatListSearchPage> createState() => _ChatListSearchPageState();
}

class _ChatListSearchPageState extends State<ChatListSearchPage> {

  // 채팅방 이름을 검색할 텍스트 필드
  TextEditingController inputChatName = TextEditingController();

  // 받아온 채팅방 정보를 담아둘 배열
  static List<String> chatImage = [];
  static List<String> chatName = [];
  static List<String> chatMsg = [];
  static List<String> chatCount = [];
  static List<String> chatTime = [];
  static List<String> chatEmail = [];

  // 읽어들인 각각의 인덱스 값을 저장할 변수
  String Chat_Read_Image = '', Chat_Read_Name = '', Chat_Read_Msg = '', Chat_Read_Count = '', Chat_Read_Time = '', Chat_Read_Email = '';

  // 읽어들인 문자열을 저장할 변수
  String Chat_Read_All = '';

  // 읽어들인 것을 저장할 배열
  static List<String> Chat_Read_Info = [];

  // 구분자로 나누어 각각의 나눈 값을 삽입할 배열
  static List<String> Chat_Split_Info = [];

  void initState(){
    // 기존의 배열에 아무것도 들어있지 않게 비워줌
    chatImage.clear();
    chatName.clear();
    chatMsg.clear();
    chatCount.clear();
    chatTime.clear();
    chatEmail.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상 중 하로 나누는 위젯
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때 화면 밀림을 방지
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경색은 흰색
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/chatList', arguments: ChatList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.black) // 뒤로가기 아이콘, 색상은 검정
        ),
        title: Text('채팅방 이름 검색', style: TextStyle(color: Colors.black)) // 검정색
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 상자 위젯
            width: double.infinity, height: double.infinity, // 가로와 세로 무제한
            child: Column( // 세로로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 아래 구분선에 색상을 줌
                      width: 1.5,
                      color: Colors.grey
                    ))
                  ),
                  width: double.infinity, height: 60, // 가로 무제한, 세로 60
                  child: Row( // 가로 정렬
                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                    children: [
                      Expanded(child: Padding( // 여백을 주기 위해 사용하는 위젯
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10), // 좌, 우, 하에 10의 여백을 줌
                        child: TextField( // 텍스트 필드 위젯
                          textAlign: TextAlign.center, // 글자를 가운데 정렬
                          controller: inputChatName, // 입력받은 값을 변수 inputChatName에 저장
                          decoration: InputDecoration(
                            hintText: '채팅방 이름 또는 친구 이름을 입력해주세요.'
                          )
                        )
                      ), flex: 8),
                      Expanded(child: IconButton(
                        onPressed: () async {
                          if(inputChatName.text == ''){
                            showDialog(barrierDismissible: false, context: context, builder: (context){
                              return Dialog(
                                child: Container(
                                  width: 150, height: 150,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity, height: double.infinity,
                                        child: Text('공백없이 입력해주세요.',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                        )
                                      ), flex: 2),
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                              },
                                            child: Text('확인')
                                          ),
                                        )
                                      ), flex: 1)
                                    ]
                                  )
                                )
                              );
                            });
                          } else {

                            // 기존의 배열에 아무것도 들어있지 않게 비워줌
                            chatImage.clear();
                            chatName.clear();
                            chatMsg.clear();
                            chatCount.clear();
                            chatTime.clear();
                            chatEmail.clear();

                            // 채팅목록을 검색하기 위한 Url 실행
                            final Search_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅방목록.php?user1=' + widget.userEmail + '&user2=' + inputChatName.text));

                            // Url의 body에 접근을 할 것임
                            dom.Document document = parse.parse(Search_response.body);

                            // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할
                            // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
                            setState(() {
                              // php 문서에서 className이 chatlist 아래에 있는 정보들을 가져와서 Read_Msg 변수에 저장
                              final Read_Msg = document.getElementsByClassName('chatlist');

                              // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
                              Chat_Read_Info = Read_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

                              // Chat_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td> & <br>를 제거함
                              Chat_Read_All = Chat_Read_Info[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');

                              // Chat_Read_All 의 값을 구분자 '&'로 나누어 배열에 저장함
                              Chat_Read_Info = Chat_Read_All.split('&');

                              // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
                              for(int i = 0; i < Chat_Read_Info.length -1; i++){
                                // Chat_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어 배열에 집어넣음
                                Chat_Split_Info = Chat_Read_Info[i].split('::');

                                // 각 배열의 인덱스 값을 문자열에 저장 해줌
                                Chat_Read_Image = Chat_Split_Info[0];
                                Chat_Read_Name = Chat_Split_Info[1];
                                Chat_Read_Msg = Chat_Split_Info[2];
                                Chat_Read_Count = Chat_Split_Info[3];
                                Chat_Read_Time = Chat_Split_Info[4];
                                Chat_Read_Email = Chat_Split_Info[5];

                                // 문자열을 각자의 배열에 삽입
                                chatImage.add(Chat_Read_Image.toString());
                                chatName.add(Chat_Read_Name.toString());
                                chatMsg.add(Chat_Read_Msg.toString());
                                chatCount.add(Chat_Read_Count.toString());
                                chatTime.add(Chat_Read_Time.toString());
                                chatEmail.add(Chat_Read_Email.toString());
                              }
                            });

                            // 만약 일치하는 채팅방이 없을 경우
                            if(Chat_Read_Info[0].contains('일치하는 채팅방이 없습니다.')){
                              showDialog(barrierDismissible: false, context: context, builder: (context){
                                return Dialog(
                                  child: Container(
                                    width: 150, height: 150,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity, height: double.infinity,
                                            child: Text('일치하는 채팅방이 없습니다.',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                            )
                                          ), flex: 2),
                                          Expanded(child: Container(
                                            width: double.infinity, height: double.infinity,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text('확인')
                                              ),
                                            )
                                          ), flex: 1)
                                        ]
                                    )
                                  )
                                );
                              });
                            }
                          }
                        },
                        icon: Icon(Icons.search, size: 30)
                      ), flex: 1)
                    ]
                  )
                ),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: ListView.builder(
                    itemCount: chatImage.length,
                    itemBuilder: (context, index){
                      // List.generate는 length의 길이만큼 0부터 index - 1 까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
                      final List<chatListInfo> chatData = List.generate(chatImage.length, (index) =>
                          chatListInfo(chatImage[index], chatName[index], chatMsg[index], chatCount[index], chatTime[index], chatEmail[index]));

                      return GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있게 해줌
                        onTap: () async { // 한번 누를 시 채팅방으로 넘어감
                          await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅방만들기.php?user1=' + widget.userEmail + '&user2=' + chatData[index].chatEmail));

                          Navigator.pushNamed(context, '/chatPage', arguments: ChatPage_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg, OtheruserEmail: chatData[index].chatEmail, OtheruserName: chatData[index].chatName));
                        },
                        onLongPress: (){ // 길게 누를 시 팝업을 띄움
                          showDialog(context: context, builder: (context){
                            return Dialog( // Dialog 위젯
                              child: Container(
                                width: 150, height: 130, // 가로 150, 세로 130
                                child: Column( // 세로 정렬
                                  mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                  children: [
                                    Expanded(child: Container(
                                      width: double.infinity, height: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey
                                        ))
                                      ),
                                      alignment: Alignment.center, // 글자는 가운데 정렬
                                      child: TextButton(
                                        onPressed: (){

                                        },
                                        child: Text('채팅방 이름 설정', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)) // 볼드체, 크기 16
                                      )
                                    ), flex: 1),
                                    Expanded(child: Container(
                                      alignment: Alignment.center, // 가운데 정렬
                                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                      child: TextButton(
                                        onPressed: (){

                                        },
                                        child: Text('방 나가기', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))
                                      )
                                    ), flex: 1)
                                  ]
                                )
                              )
                            );
                          });
                        },
                        child: Container(
                          width: double.infinity, height: 80, // 가로 무제한, 세로 80
                          child: Card( // Card 위젯 ( 모서리가 둥글다는 특징이 있음 )
                            child: Row(
                              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                              children: [
                                Expanded(child: Container(
                                  width: 100, height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.all(13),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: Image.network('http://' + chatData[index].chatImage.replaceAll('<td>', '').trim(), fit: BoxFit.cover)
                                    ),
                                  )
                                ), flex: 2),
                                Expanded(child: Container(
                                  width: 100, height: 100,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(chatData[index].chatName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                            Expanded(child: Text(chatData[index].chatTime, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey), textAlign: TextAlign.end)),
                                            SizedBox(width: 7)
                                          ]
                                        )
                                      ), flex: 1),
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: Text(chatData[index].chatMsg, style: TextStyle(color: Colors.grey))
                                      ), flex: 1)
                                    ],
                                  )
                                ), flex: 8)
                              ]
                            )
                          )
                        )
                      );
                    }
                  )
                ))
              ]
            )
          )
        )
      )

    );
  }
}

