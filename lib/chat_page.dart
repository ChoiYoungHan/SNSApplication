import 'package:application_20221022/chat_List.dart';
import 'package:flutter/material.dart';

class ChatPage_UserEmail{
  final String userEmail;
  final String userName;
  final String userStateMsg;

  ChatPage_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class chatMain extends StatelessWidget {
  const chatMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final usEmail = ModalRoute.of(context)?.settings.arguments as ChatPage_UserEmail;

    return MaterialApp(
      routes: {
        '/chatList' : (context) => chat_List(),
        '/chatPage' : (context) => chatMain()
      },
      debugShowCheckedModeBanner: false,
      home: chatPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class chatPage extends StatefulWidget {
  final userEmail, userName, userStateMsg;

  const chatPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {

  TextEditingController inputMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상 중 하로 나누는 위젯
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 색상은 흰색
        leading: IconButton( // 아이콘 버튼 (뒤로가기 기능을 넣을 것임)
          onPressed: (){ // 뒤로가기 기능이 들어갈 것임

          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 모양의 아이콘, 색상은 회색
        ),
        title: Text('친구이름', style: TextStyle(color: Colors.black)), // 친구 이름이 출력될 텍스트, 색상은 검정
        actions: [
          IconButton( // 아이콘 버튼 (검색 기능을 넣을 것임)
            onPressed: (){ // 검색 기능이 들어갈 것임

            },
            icon: Icon(Icons.search, color: Colors.grey) // 검색 아이콘, 색상은 회색
          ),
          Builder( // 자식 위젯의 context를 전달해주는 객체
              builder: (context) => IconButton( // 아이콘 버튼
                  onPressed: () => Scaffold.of(context).openEndDrawer(), // 버튼을 클릭 시 우측에서 drawer 화면이 나올 것임
                  icon: Icon(Icons.more_horiz, color: Colors.grey), // 아이콘은 more_horiz, 색상은 회색
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip // 버튼에 대한 툴팁
              )
          )
        ]
      ),
      body: SafeArea( //  MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 박스 위젯
            child: Column( // 세로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Expanded(child: Container( // 리스트뷰가 들어가서 채팅내역들을 보여줄 것임

                ), flex: 9),
                Expanded(child: Container( // 채팅을 입력할 수 있는 위젯을 만들 것임
                  width: double.infinity, height: 70, // 가로 무제한, 세로 70
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(
                      width: 1.5,
                      color: Colors.grey
                    ))
                  ),
                  child: Row( // 가로 정렬 & 텍스트 필드와 아이콘 버튼을 넣어줄 것임
                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                    children: [
                      Expanded(child: IconButton( // 아이콘 버튼
                        onPressed: (){ // 아래의 화면이 올라오게 하여 기능을 더 넣을 것임

                        },
                        icon: Icon(Icons.add_box_outlined, color: Colors.grey) // add 아이콘, 색상은 회색
                      ), flex: 1),
                      Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 10), // 왼 0, 위 0, 우 5, 아래 10의 여백을 줌
                        child: TextField( // 텍스트 필드
                          textAlign: TextAlign.center, // 텍스트를 가운데로 정렬함
                          controller: inputMessage, // 입력받은 값을 변수 inputMessage에 저장
                          decoration: InputDecoration(
                            hintText: '메시지를 입력해주세요.',
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
                        ),
                      ), flex: 8),
                      Expanded(child: IconButton( // 아이콘 버튼 위젯
                        onPressed: (){

                        },
                        icon: Icon(Icons.send, size: 30, color: Colors.grey) // 보내기 아이콘, 크기는 30
                      ), flex: 1)
                    ]
                  )
                ), flex: 1)
              ]
            )
          )
        )
      ),
      endDrawer: Drawer( // drawer 위젯, 우측에서 나오게 하기 위해 endDrawer 사용

      )
    );
  }
}

