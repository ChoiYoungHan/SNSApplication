import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/chat_page.dart';
import 'package:application_20221022/friend_profilescreen.dart';
import 'package:application_20221022/friend_searchPage.dart';
import 'package:application_20221022/my_List.dart';
import 'package:application_20221022/post_list.dart';
import 'package:application_20221022/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

import 'friend_searchPage.dart';

class FriendList_UserEmail{
  final String userEmail;
  final String userName;
  final String userStateMsg;

  FriendList_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usEmail = ModalRoute.of(context)?.settings.arguments as FriendList_UserEmail;

    return MaterialApp(
        routes: {
          '/search' : (context) => FindUser(), // FindUser 페이지로 값을 넘겨주기 위한 선언
          '/chatList' : (context) => chat_List(), // chat_List 페이지로 값을 넘겨주기 위한 선언
          '/postList' : (context) => post_List(), // post_List 페이지로 값을 넘겨주기 위한 선언
          '/myList' : (context) => my_List(), // my_List 페이지로 값을 넘겨주기 위함
          '/chatPage' : (context) => chatMain()
        },
        debugShowCheckedModeBanner: false,
        home: ListViewPage(userEmailInfo: usEmail.userEmail, userNameInfo: usEmail.userName, userStateMsgInfo: usEmail.userStateMsg)
    );
  }
}

class ListViewPage extends StatefulWidget {
  final userEmailInfo, userNameInfo, userStateMsgInfo;

  const ListViewPage({Key? key, this.userEmailInfo, this.userNameInfo, this.userStateMsgInfo}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  _ListViewPageState(){

  }

  static const routeName = '/friendList';
  // 데이터 리스트
  static List<String> LoginuserEmail = [];
  static List<String> LoginuserName = [];
  static List<String> LoginuserStateMsg = [];

  static List<String> Friend_userUID = [];
  static List<String> Friend_userEmail = [];
  static List<String> Friend_userName = [];
  static List<String> Friend_userImage = [];
  static List<String> Friend_userStateMsg = [];
  static List<String> Friend_userNickname = [];

  String Email = '';
  String Friend_Read_UID = '', Friend_Read_Email = '', Friend_Read_Name = '', Friend_Read_Image = '', Friend_Read_StateMsg = '', Friend_Read_Nickname = '';

  String Friend_Read_All = '';
  var Friend_Read_Userinfo = <String>[];

  static List<String> Friend_split_info = [];

  TextEditingController inputFriendEmail = TextEditingController();

  void initState(){

    getFriendInfo();
  }

  void getFriendInfo() async {
    LoginuserEmail.clear();
    LoginuserName.clear();
    LoginuserStateMsg.clear();

    Friend_userUID.clear();
    Friend_userEmail.clear();
    Friend_userName.clear();
    Friend_userImage.clear();
    Friend_userStateMsg.clear();
    Friend_userNickname.clear();

    final Friend_response = await http.get(Uri.parse(
        'http://www.teamtoktok.kro.kr/친구목록.php?user1=' + widget.userEmailInfo
    ));

    dom.Document document = parse.parse(Friend_response.body);

    setState(() {
      final Friend_Read_Msg = document.getElementsByClassName('friendlist');

      Friend_Read_Userinfo = Friend_Read_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();
      Friend_Read_All = Friend_Read_Userinfo[0].replaceAll(RegExp('(<td>|</td>)'), '');

      Friend_Read_Userinfo = Friend_Read_All.split('///');

      for(int i = 0; i < Friend_Read_Userinfo.length-1; i++){
        Friend_split_info = Friend_Read_Userinfo[i].split('::');
        Friend_Read_UID = Friend_split_info[0];
        Friend_Read_Email = Friend_split_info[1];
        Friend_Read_Name = Friend_split_info[2];
        Friend_Read_StateMsg = Friend_split_info[3];
        Friend_Read_Image = Friend_split_info[4];
        Friend_Read_Nickname = Friend_split_info[5];

        LoginuserEmail.add(widget.userEmailInfo.toString());
        LoginuserName.add(widget.userNameInfo.toString());
        LoginuserStateMsg.add(widget.userStateMsgInfo.toString());

        Friend_userUID.add(Friend_Read_UID.toString());
        Friend_userEmail.add(Friend_Read_Email.toString());
        Friend_userName.add(Friend_Read_Name.toString());
        Friend_userStateMsg.add(Friend_Read_StateMsg.toString());
        Friend_userImage.add(Friend_Read_Image.toString());
        Friend_userNickname.add(Friend_Read_Nickname.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<userProfile> userData = List.generate(Friend_userEmail.length, (index) =>
        userProfile(LoginuserEmail[index], LoginuserName[index], LoginuserStateMsg[index], Friend_userUID[index], Friend_userEmail[index], Friend_userName[index], Friend_userImage[index], Friend_userImage[index], Friend_userStateMsg[index], Friend_userNickname[index]));

    return Scaffold( // 상 중 하로 나눌때는 Scaffold 위젯을 사용
        appBar: AppBar( // 상단바
          backgroundColor: Colors.white, // 배경은 흰색
          title: Text('친구', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff797979))), // 상단바에 텍스트로 '친구' 출력, 글자의 두께를 줄임
          actions: [ // 상단바의 우측에 배치
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/search', arguments: SearchPage_UserEmail(getLoginEmail: widget.userEmailInfo, getLoginName: widget.userNameInfo, getLoginStateMsg: widget.userStateMsgInfo));
                },
                icon: Icon(Icons.search, color: Colors.grey)), // 검색 아이콘 버튼
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
                                          controller: inputFriendEmail,
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
                                            setState(() {
                                              Email = inputFriendEmail.text;
                                            });
                                            final Friend_add_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/친구추가.php?user1=' + widget.userEmailInfo + '&user2=' + Email));
                                            Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmailInfo, userName: widget.userNameInfo, userStateMsg: widget.userStateMsgInfo));
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
                icon: Icon(Icons.person_add_alt, color: Colors.grey)), // 친구 추가 아이콘 버튼
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/chatPage', arguments: ChatPage_UserEmail(userEmail: widget.userEmailInfo, userName: widget.userNameInfo, userStateMsg: widget.userStateMsgInfo));
                },
                icon: Icon(Icons.settings, color: Colors.grey)), // 설정 아이콘 버튼
          ],
        ),
        body: ListView.builder( // ListView
            itemCount: Friend_userName.length, // List의 개수는 friendList의 개수만큼
            itemBuilder: (context, index){
              return GestureDetector( // 제스처를 사용할 때 사용하는 위젯
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => friend_profileScreen(profile: userData[index])));
                },
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
                                    child: TextButton(
                                        onPressed: () async {
                                          final Friend_Delete = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/친구차단.php?user1=' + widget.userEmailInfo + '&user2=' + userData[index].userEmail));
                                          print('http://www.teamtoktok.kro.kr/친구차단.php?user1=' + widget.userEmailInfo + '&user2=' + userData[index].userEmail);
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
                                                      child: Text(userData[index].userName + '님을 차단하였습니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                                                    ), flex: 2),
                                                    Expanded(child: Container(
                                                      width: double.infinity, height: double.infinity,
                                                      child: ElevatedButton(
                                                        onPressed: (){
                                                          Navigator.pop(context);
                                                          Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmailInfo, userName: widget.userNameInfo, userStateMsg: widget.userStateMsgInfo));
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
                                        child: Text('차단', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black))
                                    )
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
                                child: Image.asset(userData[index].userImage, width: 100, height: 100, fit: BoxFit.cover)
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
                                child: Text(userData[index].userNickname,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1),
                              ),
                            ), flex: 1),
                            Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                              padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                              child: Container(
                                width: double.infinity, height: double.infinity,
                                child: Text(userData[index].userState,
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
                      Navigator.pushNamed(context, '/chatList', arguments: ChatList_UserEmail(userEmail: widget.userEmailInfo, userName: widget.userNameInfo, userStateMsg: widget.userStateMsgInfo)); // 채팅 목록 페이지로 이동 및 인자값 전달
                    },
                    icon: Icon(Icons.chat_bubble_outline)), // 채팅목록 아이콘버튼
                IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmailInfo, userName: widget.userNameInfo, userStateMsg: widget.userStateMsgInfo)); // 게시글 목록 페이지로 이동 및 인자값 전달
                    },
                    icon: Icon(Icons.list_alt)), // 게시글목록 아이콘버튼
                IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/myList', arguments: MyList_UserEmail(userEmail: widget.userEmailInfo, userName: widget.userNameInfo, userStateMsg: widget.userStateMsgInfo)); // 전체 목록 페이지로 이동 및 인자값 전달
                    },
                    icon: Icon(Icons.segment)), // 전체목록 아이콘버튼
              ],
            ),
          ),
        )
    );
  }
}

