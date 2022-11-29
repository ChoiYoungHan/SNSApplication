import 'package:application_20221022/chatRoomInfo.dart';
import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class ChatPage_UserEmail{
  final String userEmail;
  final String userName;
  final String userStateMsg;
  final String OtheruserEmail;
  final String OtheruserName;

  ChatPage_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg, required this.OtheruserEmail, required this.OtheruserName});
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
      home: chatPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg, OtheruserEmail: usEmail.OtheruserEmail, OtheruserName: usEmail.OtheruserName)
    );
  }
}

class chatPage extends StatefulWidget {
  final userEmail, userName, userStateMsg, OtheruserEmail, OtheruserName;

  const chatPage({Key? key, this.userEmail, this.userName, this.userStateMsg, this.OtheruserEmail, this.OtheruserName}) : super(key: key);

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {

  // 메시지를 입력할 때 사용할 텍스트 필드
  TextEditingController inputMessage = TextEditingController();

  // 받아온 메시지 정보를 저장할 배열
  static List<String> MsgUID = [];
  static List<String> MsgEmail = [];
  static List<String> MsgSendName = [];
  static List<String> MsgContents = [];
  static List<String> MsgSendTime = [];

  // 받아온 정보를 각각의 문자열에 저장한 다음 위의 배열에 넣을 것임
  String Read_MsgUID = '', Read_MsgEmail = '', Read_MsgSendName = '', Read_MsgContents = '', Read_MsgSendTime = '';

  // 받아온 문자열 전체를 저장할 변수
  String Msg_Read_All = '';

  // 읽어온 정보를 담아둘 배열과 각각의 정보를 나눠서 담을 배열
  var Msg_Read_Info = <String>[];
  var Msg_Split_Info = <String>[];

  void initState(){
    getMsgInfo();
  }

  void getMsgInfo() async {
    // 기존의 배열에 아무것도 들어있지 않게 비워줌
    MsgUID.clear();
    MsgEmail.clear();
    MsgSendName.clear();
    MsgContents.clear();
    MsgSendTime.clear();

    // 채팅내용을 불러올 Url 실행
    final Msg_response =
        await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅내용.php?user1=' + widget.userEmail + '&user2=' + widget.OtheruserEmail));

    // 문서... Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(Msg_response.body);

    // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할
    // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
    setState(() {

      // php 문서에서 className이 chatinfo 아래에 있는 정보들을 가져와서 Msg_Read_Msg에 저장
      final Msg_Read_Msg = document.getElementsByClassName('chatinfo');

      // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
      Msg_Read_Info = Msg_Read_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

      // Msg_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td> & <br>
      Msg_Read_All = Msg_Read_Info[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');

      // Msg_Read_All 의 값을 구분자 '&'로 나누어 배열에 저장함
      Msg_Read_Info = Msg_Read_All.split('&');

      // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
      for(int i = 0; i < Msg_Read_Info.length - 1; i++){
        // Msg_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어서 배열에 집어넣음
        Msg_Split_Info = Msg_Read_Info[i].split('::');

        // 각 배열의 인덱스 값을 문자열에 저장을 해줌
        Read_MsgUID = Msg_Split_Info[0];
        Read_MsgEmail = Msg_Split_Info[1];
        Read_MsgSendName = Msg_Split_Info[2];
        Read_MsgContents = Msg_Split_Info[3];
        Read_MsgSendTime = Msg_Split_Info[4];

        // 문자열을 각자의 배열에 삽입
        MsgUID.add(Read_MsgUID.toString());
        MsgEmail.add(Read_MsgEmail.toString());
        MsgSendName.add(Read_MsgSendName.toString());
        MsgContents.add(Read_MsgContents.toString());
        MsgSendTime.add(Read_MsgSendTime.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // List.generate는 length의 길이만큼 0부터 index - 1까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
    final List<ChatRoomInfo> chatRoomData = List.generate(MsgUID.length, (index) =>
        ChatRoomInfo(MsgUID[index], MsgEmail[index], MsgSendName[index], MsgContents[index], MsgSendTime[index]));

    return Scaffold( // 상 중 하로 나누는 위젯
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 색상은 흰색
        leading: IconButton( // 아이콘 버튼 (뒤로가기 기능을 넣을 것임)
          onPressed: (){ // 뒤로가기 기능이 들어갈 것임

          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 모양의 아이콘, 색상은 회색
        ),
        title: Text(widget.OtheruserName, style: TextStyle(color: Colors.black)), // 친구 이름이 출력될 텍스트, 색상은 검정
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
                  child: ListView.builder(
                    itemCount: MsgUID.length,
                    itemBuilder: (context, index){
                    return Chat_Bubble(message: chatRoomData[index].MsgContents, writer: chatRoomData[index].MsgEmail, Loginuser: widget.userEmail, Otheruser: widget.OtheruserEmail);
                  }),
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
                        onPressed: () async {
                          final send_response =
                            await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅입력.php?user1=' + widget.userEmail + '&user2=' + widget.OtheruserEmail + '&message=' + inputMessage.text));
                          Navigator.pushNamed(context, '/chatPage', arguments: ChatPage_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg, OtheruserEmail: widget.OtheruserEmail, OtheruserName: widget.OtheruserName));
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

