import 'package:application_20221022/chat_page.dart';
import 'package:application_20221022/friend_profilescreen.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class ChatSearchPage_UserEmail{ // 로그인한 사용자의 이메일 정보를 담아둘 클래스 객체 선언
  final String getLoginEmail;
  final String getLoginName;
  final String getLoginStateMsg;

  ChatSearchPage_UserEmail({required this.getLoginEmail, required this.getLoginName, required this.getLoginStateMsg});
}

class chatFindUser extends StatelessWidget {
  const chatFindUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getUserEmail = ModalRoute.of(context)?.settings.arguments as ChatSearchPage_UserEmail; // SearchPage_UserEmail 클래스의 인자값을 받아오기 위함

    return MaterialApp(
        routes: {
          '/chatPage' : (context) => chatMain() // MyApp 페이지로 값을 넘겨주기 위한 선언
        },
        debugShowCheckedModeBanner: false,
        home: chatFindUserPage(userEmail: getUserEmail.getLoginEmail, userName: getUserEmail.getLoginName, userStateMsg: getUserEmail.getLoginStateMsg)
    );
  }
}

class chatFindUserPage extends StatefulWidget {
  final userEmail, userName, userStateMsg;

  const chatFindUserPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);

  @override
  State<chatFindUserPage> createState() => _chatFindUserPageState();
}

class _chatFindUserPageState extends State<chatFindUserPage> {

  static const routeName = '/search'; // 값을 받기 위함

  // 친구 이름을 검색할 텍스트 필드
  TextEditingController inputFriendName = TextEditingController();

  // 로그인한 유저의 정보를 담아줄 배열
  static List<String> LoginuserEmail = [];
  static List<String> LoginuserName = [];
  static List<String> LoginuserStateMsg = [];

  // 받아온 친구 정보를 담아둘 배열
  static List<String> Friend_userUID = [];
  static List<String> Friend_userEmail = [];
  static List<String> Friend_userName = [];
  static List<String> Friend_userImage = [];
  static List<String> Friend_userStateMsg = [];
  static List<String> Friend_userNickname = [];

  // 받아온 정보를 각각의 문자열에 저장한 다음 위의 배열에 넣을 것임
  String Friend_Read_UID = '', Friend_Read_Email = '', Friend_Read_Name = '', Friend_Read_Image = '', Friend_Read_StateMsg = '', Friend_Read_Nickname = '';

  // 받아온 문자열 전체를 저장할 변수
  String Friend_Read_All = '';

  // 읽어온 정보를 담아둘 배열과 각각의 유저 정보를 나눠서 담을 배열
  var Friend_Read_UserInfo = <String>[];
  var Friend_Split_UserInfo = <String>[]; // split을 이용하여 나눈 정보를 담을 것임ㅍㅁㄱ

  @override
  void initState() {
    // 기존의 배열에 아무것도 들어있지 않게 비워줌
    LoginuserEmail.clear();
    LoginuserName.clear();
    LoginuserStateMsg.clear();

    Friend_userUID.clear();
    Friend_userEmail.clear();
    Friend_userName.clear();
    Friend_userImage.clear();
    Friend_userStateMsg.clear();
    Friend_userNickname.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때 화면 밀림을 방지
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (){ // 친구목록 페이지로 갈것임 & 로그인 한 사용자의 정보를 넘겨줘야 함
                Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
              },
              icon: Icon(Icons.arrow_back, color: Colors.black) // 뒤로가기 아이콘 & 색깔은 블랙
          ),
          title: Text('친구찾기', style: TextStyle(color: Colors.black))
      ),
      body: SafeArea( //  MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
          child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
              child: Container(
                  width: double.infinity, height: double.infinity,
                  child: Column( // 세로로 정렬
                      mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                      children: [
                        Container(
                            decoration: BoxDecoration( // 아래에 구분선을 줌
                                border: Border(bottom: BorderSide(
                                    width: 1.5,
                                    color: Color(0xffC6C8C6)
                                ))
                            ),
                            width: double.infinity, height: 70, // 가로 무제한, 세로 70
                            child: Row( // 가로 정렬 & 텍스트 필드와 아이콘 버튼을 넣어줄 것임
                                mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                children: [
                                  Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10), // 왼 10, 위 0, 우 10, 아래 10의 여백을 줌
                                    child: TextField( // 텍스트 필드
                                        textAlign: TextAlign.center, // 텍스트를 가운데로 정렬함
                                        controller: inputFriendName, // 입력받은 값을 변수 inputFriendName에 저장
                                        decoration: InputDecoration(
                                            hintText: '친구 이름을 입력해주세요.',
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
                                      onPressed: () async { // 검색 버튼을 누를 시 DB에서 친구의 정보를 가져올 것임

                                        // 기존의 배열에 아무것도 들어있지 않게 비워줌
                                        Friend_userUID.clear();
                                        Friend_userEmail.clear();
                                        Friend_userName.clear();
                                        Friend_userImage.clear();
                                        Friend_userStateMsg.clear();
                                        Friend_userNickname.clear();

                                        // 친구를 검색하기 위한 Url 실행
                                        final Friend_response =
                                        await http.get(Uri.parse('http://www.teamtoktok.kro.kr/친구목록.php?user1=' + widget.userEmail + '&user2=' + inputFriendName.text));

                                        // 문서... Url의 body에 접근을 할 것임
                                        dom.Document document = parse.parse(Friend_response.body);

                                        // setState() 함수 안에서의 호출은 State 에서 무언가 변경된 사항이 있음을 Flutter Framework 에 알려주는 역할이다.
                                        // 이로 인해 UI 에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
                                        setState(() {

                                          // php 문서에서 className이 friendlist 아래에 있는 정보들을 가져와서 Friend_Read_Msg에 저장
                                          final Friend_Read_Msg = document.getElementsByClassName('friendlist');

                                          // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
                                          Friend_Read_UserInfo = Friend_Read_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

                                          // Firned_Read_UserInfo 배열의 0번째 index값의 문자열중, <td> & </td>를 제거함
                                          Friend_Read_All = Friend_Read_UserInfo[0].replaceAll(RegExp('(<td>|</td>)'), '');

                                          // Friend_Read_All의 값을 구분자 '///'로 나누어 배열의 저장함
                                          Friend_Read_UserInfo = Friend_Read_All.split('///');

                                          // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
                                          for(int i = 0; i < Friend_Read_UserInfo.length-1; i++){
                                            // Friend_Read_UserInfo 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어서 배열에 집어넣음
                                            Friend_Split_UserInfo = Friend_Read_UserInfo[i].split('::');

                                            // 각 배열의 인덱스 값을 문자열에 저장을 해줌
                                            Friend_Read_UID = Friend_Split_UserInfo[0];
                                            Friend_Read_Email = Friend_Split_UserInfo[1];
                                            Friend_Read_Name = Friend_Split_UserInfo[2];
                                            Friend_Read_StateMsg = Friend_Split_UserInfo[3];
                                            Friend_Read_Image = Friend_Split_UserInfo[4];
                                            Friend_Read_Nickname = Friend_Split_UserInfo[5];

                                            // 문자열을 각자의 배열에 삽입
                                            LoginuserEmail.add(widget.userEmail.toString());
                                            LoginuserName.add(widget.userName.toString());
                                            LoginuserStateMsg.add(widget.userStateMsg.toString());

                                            Friend_userUID.add(Friend_Read_UID.toString());
                                            Friend_userEmail.add(Friend_Read_Email.toString());
                                            Friend_userName.add(Friend_Read_Name.toString());
                                            Friend_userStateMsg.add(Friend_Read_StateMsg.toString());
                                            Friend_userImage.add(Friend_Read_Image.toString());
                                            Friend_userNickname.add(Friend_Read_Nickname.toString());
                                          }
                                        });

                                        // 텍스트 필드를 비워줌
                                        inputFriendName.clear();

                                        // 만약 일치하는 이름이 없을 경우
                                        if(Friend_Read_UserInfo[0].contains('일치하는 사용자가 없습니다.')){
                                          showDialog(context: context, builder: (context){ // 팝업 화면을 보여줌
                                            return Dialog( // Dialog 위젯
                                                child: Container( // 박스 위젯
                                                    width: 150, height: 150, // 가로 150, 세로 150
                                                    child: Column( // 세로 정렬
                                                        mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                        children: [
                                                          Expanded(child: Container( // 박스 위젯
                                                              decoration: BoxDecoration(
                                                                  border: Border(bottom: BorderSide( // 박스의 아래 테두리에 색을 줄 것임
                                                                      color: Color(0xffC6C8C6),
                                                                      width: 1.5
                                                                  ))
                                                              ),
                                                              alignment: Alignment.center, // 글자를 가운데로 오도록 함
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Text('일치하는 이름이 없습니다.',
                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16) // 볼드체, 크기 16
                                                              )
                                                          ), flex: 2),
                                                          Expanded(child: Container( // 박스 위젯
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: ElevatedButton( // 버튼위젯
                                                                  onPressed: (){ // 클릭 시 Dialog위젯을 종료함
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
                                        }
                                      },
                                      icon: Icon(Icons.search, size: 30) // 검색 아이콘, 크기는 30
                                  ), flex: 1)
                                ]
                            )
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity, height: double.infinity, // 가로 무제한
                            child: ListView.builder( // 리스트뷰 위젯
                                itemCount: Friend_userName.length,
                                itemBuilder: (context, index){

                                  // List.generate는 length의 길이만큼 0부터 index - 1까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
                                  final List<userProfile> userData = List.generate(Friend_userEmail.length, (index) =>
                                      userProfile(LoginuserEmail[index], LoginuserName[index], LoginuserStateMsg[index], Friend_userUID[index], Friend_userEmail[index], Friend_userName[index], Friend_userImage[index], Friend_userImage[index], Friend_userStateMsg[index], Friend_userNickname[index]));

                                  return GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
                                      onTap: (){ // 한 번 클릭 시 friend_profilescreen으로 넘어가게 해 줄 것임. 값 전달 필요
                                        Navigator.pushNamed(context, '/chatPage', arguments: ChatPage_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg, OtheruserEmail: userData[index].userEmail, OtheruserName: userData[index].userName));
                                      },
                                      onLongPress: (){ // 길게 누를 시, 친구목록 화면과 같이 구현
                                        showDialog( // 팝업 화면을 띄우기 위함
                                            context: context,
                                            barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                                            builder: (context){
                                              return Dialog( // Dialog 위젯을 사용
                                                child: Container(
                                                    width: 150, height: 150,
                                                    child: Column( // 세로 정렬
                                                        mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                        children: [
                                                          Expanded(child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border(bottom: BorderSide( // 박스의 아래 테두리에 색을 줄 것임
                                                                      color: Color(0xffC6C8C6),
                                                                      width: 1.5
                                                                  ))
                                                              ),
                                                              alignment: Alignment.center, // 글자가 가운데로 오도록
                                                              width: double.infinity, height: double.infinity, // 가로, 세로 무제한
                                                              child: TextButton( // 텍스트 버튼 위젯
                                                                  onPressed: (){ // 버튼을 클릭 시 친구의 이름을 변경하는 팝업화면을 띄울 것임

                                                                  },
                                                                  child: Text('이름변경', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)) // 볼드체, 사이즈 16, 색상은 회색
                                                              )
                                                          ), flex: 1),
                                                          Expanded(child: Container(
                                                            alignment: Alignment.center, // 글자가 가운데로 오도록 함
                                                            width: double.infinity, height: double.infinity, // 가로와 세로를 무제한으로
                                                            child: TextButton( // 텍스트 버튼 위젯
                                                                onPressed: () async { // 버튼을 클릭 시 친구를 친구 목록에서 삭제함 ( 친구의 목록에서도 삭제됨 )
                                                                  // 친구를 삭제하기 위한 Url 실행
                                                                  final Friend_Delete =
                                                                  await http.get(Uri.parse('http://www.teamtoktok.kro.kr/친구차단.php?user1=' + widget.userEmail + '&user2=' + userData[index].userEmail));

                                                                  // 친구 차단을 완료하면 차단 하였다는 팝업 출력
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (context){
                                                                        return Dialog( // Dialog 위젯
                                                                            child: Container( // 박스 위젯
                                                                                width: 150, height: 150, // 가로와 세로 150
                                                                                child: Column( // 세로 정렬
                                                                                    mainAxisSize: MainAxisSize.max, // 남은 공간을 모두 사용
                                                                                    children: [
                                                                                      Expanded(child: Container( // 박스 위젯
                                                                                          decoration: BoxDecoration( // Container 위젯을 꾸미기 위해 사용
                                                                                              border: Border(bottom: BorderSide(
                                                                                                  color: Color(0xffC6C8C6), // 박스의 아래 테두리에 색을 줌
                                                                                                  width: 1.5
                                                                                              ))
                                                                                          ),
                                                                                          alignment: Alignment.center, // 글자를 가운데로 오도록 함
                                                                                          width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                                          child: Text(userData[index].userNickname + '님을 차단하였습니다.',
                                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체, 크기 16
                                                                                      ), flex: 2),
                                                                                      Expanded(child: Container(
                                                                                          width: double.infinity, height: double.infinity, // 가로, 세로 무제한
                                                                                          child: ElevatedButton( // 버튼 위젯
                                                                                            onPressed: (){ // 버튼을 누르면 친구목록으로 넘어갈 것임
                                                                                              Navigator.pop(context);
                                                                                              Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                                                                                            },
                                                                                            child: Text('확인'),
                                                                                          )
                                                                                      ), flex: 1)
                                                                                    ]
                                                                                )
                                                                            )
                                                                        );
                                                                      }
                                                                  );
                                                                },
                                                                child: Text('차단', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)) // 볼드체, 사이즈 16, 색상은 회색
                                                            ),
                                                          ), flex: 1)
                                                        ]
                                                    )
                                                ),
                                              );
                                            }
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity, height: 110, // 가로 무제한, 세로 110
                                        child: Card( // 카드 위젯, 모서리가 둥글다는 특징이 있음
                                            child: Row( // 가로 정렬
                                                mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                children: [
                                                  Expanded(child: Container(
                                                    child: Padding( // 여백을 줄 때 사용하는 위젯
                                                        padding: EdgeInsets.all(10), // 모든 면의 여백을 10만큼 줌
                                                        child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용하는 위젯
                                                            borderRadius: BorderRadius.circular(35), // 각진 부분을 35만큼 둥글게 줄임
                                                            child: Image.asset(userData[index].userImage, width: 100, height: 100, fit: BoxFit.cover) // 이미지 삽입, 이미지는 최대로
                                                        )
                                                    ),
                                                  ), flex: 3),
                                                  Expanded(child: Container(
                                                      child: Column( // 세로 정렬
                                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                          children: [
                                                            Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                                                                padding: EdgeInsets.fromLTRB(5, 20, 5, 5), // 좌 5 위 20 우 5 하 5의 여백을 줌
                                                                child: Container(
                                                                    width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
                                                                    child: Text(userData[index].userNickname,
                                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1)
                                                                  // 텍스트의 사이즈 20, 볼드체, 색상은 검정, 최대 라인수 1
                                                                )
                                                            ), flex: 1),
                                                            Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                                                                padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                                                                child: Container(
                                                                    width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
                                                                    child: Text(userData[index].userState,
                                                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey), maxLines: 1)
                                                                  // 텍스트의 사이즈 15, 볼드체, 색상은 회색, 최대 라인수 1
                                                                )
                                                            ), flex: 1)
                                                          ]
                                                      )
                                                  ), flex: 8)
                                                ]
                                            )
                                        ),
                                      )
                                  );
                                }),
                          ),
                        )
                      ]
                  )
              )
          )
      ),
    );
  }
}
