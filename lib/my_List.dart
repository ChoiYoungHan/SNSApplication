import 'package:application_20221022/News_List.dart';
import 'package:application_20221022/appversion.dart';
import 'package:application_20221022/black_List.dart';
import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/post_list.dart';
import 'package:application_20221022/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

import 'friendlist.dart';


class MyList_UserEmail{ // 로그인한 사용자의 이메일 정보를 담아둘 클래스 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  MyList_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class my_List extends StatelessWidget {
  const my_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usEmail = ModalRoute.of(context)?.settings.arguments as MyList_UserEmail; // MyList_UserEmail 클래스에 들어있는 인자값을 가져오기 위함

    return MaterialApp(
      routes: {
        '/friendList' : (context) => MyApp(), // MyApp 페이지로 값을 넘겨주기 위함
        '/chatList' : (context) => chat_List(), // chat_List 페이지로 값을 넘겨주기 위함
        '/postList' : (context) => post_List(), // post_List 페이지로 값을 넘겨주기 위함
        '/blackList' : (context) => black_List(), // black_List 페이지로 값을 넘겨주기 위함
        '/profileEdit' : (context) => profile_edit(), // profile_edit 페이지로 값을 넘겨주기 위함
        '/appversion' : (context) => appversion(), // appversion 페이지로 값을 넘겨주기 위함
        '/newsList' : (context) => news_List() // news_List 페이지로 값을 넘겨주기 위함
      },
      debugShowCheckedModeBanner: false,
      home: MyListPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class MyListPage extends StatefulWidget {
  final userEmail, userName, userStateMsg;

  const MyListPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {

  static const routeName = '/myList'; // 값을 받기 위함

  // 회원탈퇴 시 입력한 이메일과 비밀번호 값을 저장할 변수
  TextEditingController Delete_inputEmail = TextEditingController();
  TextEditingController Delete_inputPassword = TextEditingController();

  // 받아온 문자열 전체를 저장할 변수
  String getAll = '';

  // 읽어온 정보를 담아둘 배열
  var getInfo = <String>[];

  // 데이터리스트
  static List<String> userImage = [];
  static List<String> userNickname = [];
  static List<String> userStateMsg = [];

  // 받아온 정보를 각각의 문자열에 저장한 다음 위의 배열에 넣을 것임
  String User_Read_Image = '', User_Read_Nickname = '', User_Read_StateMsg = '';

  // 읽어온 정보를 담아둘 배열과 각각의 유저 정보를 나눠서 담을 배열
  static List<String> User_Info = [];

  // 읽어온 문자열 전체를 저장할 변수
  String User_Read_All = '';

  static List<String> User_Split_Info = [];

  @override
  void initState() {
    userInfo();
  }

  void userInfo() async {
    userImage.clear();
    userNickname.clear();
    userStateMsg.clear();

    // 유저 정보를 검색하기 위한 Url 실행
    final User_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/정보검색.php?id=' + widget.userEmail));

    // Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(User_response.body);

    setState(() {
      final User_Msg = document.getElementsByClassName('searchuser');

      User_Info = User_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

      User_Read_All = User_Info[0].replaceAll(RegExp('(<td>|</td>)'), '');

      User_Split_Info = User_Read_All.split('::');

      User_Read_Image = User_Split_Info[0];
      User_Read_Nickname = User_Split_Info[1];
      User_Read_StateMsg = User_Split_Info[2];

      print('User_Read_Image' + User_Read_Image);
      print('User_Read_Nickname' + User_Read_Nickname);
      print('User_Read_StateMsg' + User_Read_StateMsg);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상 중 하로 나누는 위젯
      resizeToAvoidBottomInset: false, // 채팅바가 올라올 때 화면 밀림 방지지
     appBar: AppBar(
        backgroundColor: Colors.white, // 배경색을 흰색으로
        title: Text('My', style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff797979))) // 상단바에 텍스트로 'My' 출력, 글자의 두께를 줄임
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여함
          child: Container( // 박스 위젯
            width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
            child: Column( // 세로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Container(
                  width: double.infinity, height: 130, // 가로 무제한, 세로 130
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 박스 위젯의 아래 테두리에 색을 줌
                      width: 1.5,
                      color: Color(0xffC6C8C6)
                    ))
                  ),
                  child: Row( // 가로정렬
                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                    children: [
                      Expanded(child: Container( // 박스 위젯
                        width: double.infinity, height: double.infinity, // 가로, 세로 무제한
                        child: Padding( // 여백을 주기 위해 사용하는 위젯
                          padding: EdgeInsets.all(10), // 모든 면의 여백을 10만큼 줌
                          child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용
                            borderRadius: BorderRadius.circular(35), // 네 모서리를 35만큼 둥글게 함
                            child: Image.network('http://' + User_Read_Image.trim(), width: 100, height: 100, fit: BoxFit.cover) // 사진은 꽉 차게
                          )
                        )
                      ), flex: 4),
                      Expanded(child: Container(
                        width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
                        child: Column(
                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 일정한 간격을 두고 배치
                          children: [
                            Align( // 정렬할 때 사용하는 위젯
                              alignment: Alignment.centerLeft, // 가운데 왼쪽에 배치
                              child: Text(User_Read_Nickname, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)) // 볼드체, 사이즈 20
                            ),
                            Align( // 정렬할 때 사용하는 위젯
                              alignment: Alignment.centerLeft, // 가운데 왼쪽에 배치
                              child: Text(User_Read_StateMsg, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)) // 볼드체, 사이즈 16, 색상은 회색
                            )
                          ]
                        )
                      ), flex: 7)
                    ]
                  ),
                ),
                Container( // 상자 위젯
                  alignment: Alignment.centerLeft, // 가운데 왼쪽으로 정렬
                  width: double.infinity, height: 50, // 가로 무제한, 세로 60
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 박스 위젯의 아래 테두리에 색을 주기 위함
                      width: 1.5,
                      color: Color(0xffC6C8C6)
                    ))
                  ),
                  child: TextButton( // 텍스트 버튼 위젯
                    onPressed: (){
                      Navigator.pushNamed(context, '/profileEdit', arguments: ProfileEdit_UserEmil(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                    },
                    child: Padding( // 여백을 주기 위해 사용하는 위젯
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                      child: Text('프로필 편집', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
                  )
                ),
                Container( // 상자 위젯
                  alignment: Alignment.centerLeft, // 가운데 왼쪽으로 정렬
                  width: double.infinity, height: 50, // 가로 무제한, 세로 60
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 박스 위젯의 아래 테두리에 색을 주기 위함
                      width: 1.5,
                      color: Color(0xffC6C8C6)
                    ))
                  ),
                  child: TextButton( // 텍스트 버튼 위젯
                     onPressed: (){
                       Navigator.pushNamed(context, '/blackList', arguments: BlackList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userName));
                     },
                     child: Padding( // 여백을 주기 위해 사용하는 위젯
                       padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                       child: Text('차단친구 관리', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
                  )
                ),
                Container( // 상자 위젯
                  alignment: Alignment.centerLeft, // 가운데 왼쪽으로 정렬
                  width: double.infinity, height: 50, // 가로 무제한, 세로 60
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 박스 위젯의 아래 테두리에 색을 주기 위함
                      width: 1.5,
                      color: Color(0xffC6C8C6)
                    ))
                  ),
                  child: TextButton( // 텍스트 버튼 위젯
                    onPressed: () {
                      Navigator.pushNamed(context, '/newsList', arguments: NewsList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                    },
                    child: Padding( // 여백을 주기 위해 사용하는 위젯
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                      child: Text('공지사항', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
                  )
                ),
                Container( // 상자 위젯
                  alignment: Alignment.centerLeft, // 가운데 왼쪽으로 정렬
                  width: double.infinity, height: 50, // 가로 무제한, 세로 60
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 박스 위젯의 아래 테두리에 색을 주기 위함
                      width: 1.5,
                      color: Color(0xffC6C8C6)
                    ))
                  ),
                  child: TextButton( // 텍스트 버튼 위젯
                    onPressed: (){
                      Navigator.pushNamed(context, '/appversion', arguments: AppVersion_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                    },
                    child: Padding( // 여백을 주기 위해 사용하는 위젯
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                      child: Text('앱 버전', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
                  )
                ),
                Container(
                  width: double.infinity, height: 50, // 가로 무제한, 세로 60
                  child: Row(
                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 일정 간격을 두고 출력
                    children: [
                      TextButton( // 텍스트 버튼 위젯
                        onPressed: () async { // 버튼 클릭 시 회원 탈퇴를 할 것임 + 로그인 화면으로 이동
                          // 회원 탈퇴 진행 시 팝업 화면을 띄운 뒤 이메일과 비밀번호를 입력받을 것임
                          showDialog(
                            context: context,
                            barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                            builder: (context) {
                              return Dialog( // Dialog 위젯을 사용
                                child: Container(
                                  width: 150, height: 240, // 가로 150, 세로 300
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container( // 상자 위젯
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide( // 박스 위젯의 아래 테두리에 색상을 주기 위함
                                            color: Color(0xffC6C8C6),
                                            width: 1.5
                                          ))
                                        ),
                                        alignment: Alignment.center, // 가운데 정렬
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: Text('회원탈퇴', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) // 볼드체, 크기는 16
                                      ), flex: 2),
                                      Expanded(child: Container( // 상자 위젯
                                        child: Column( // 세로 정렬
                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 일정 간격을 두고 정렬
                                          children: [
                                            Padding( // 여백을 주기 위해 사용하는 위젯
                                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 왼 10 위 5 아래 10 우 5의 여백을 줌
                                              child: TextField( // 텍스트 필드
                                                textAlign: TextAlign.center, // 텍스트를 가운데로 정렬
                                                controller: Delete_inputEmail, // 입력받은 값을 변수 Delete_inpustEmail에 저장
                                                decoration: InputDecoration(
                                                  hintText: '이메일을 입력해주세요.',
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
                                                  focusedErrorBorder: UnderlineInputBorder(
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
                                                  )
                                                )
                                              )
                                            ),
                                            Padding( // 여백을 주기 위해 사용하는 위젯
                                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 왼 10 위 5 아래 10 우 5의 여백을 줌
                                              child: TextField( // 텍스트 필드
                                                textAlign: TextAlign.center, // 텍스트를 가운데로 정렬
                                                controller: Delete_inputPassword, // 입력받은 값을 변수 Delete_inpustPassword에 저장
                                                decoration: InputDecoration(
                                                  hintText: '비밀번호를 입력해주세요.',
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
                                                  focusedErrorBorder: UnderlineInputBorder(
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
                                                  )
                                                )
                                              )
                                            )
                                          ]
                                        )
                                      ), flex: 8),
                                      Expanded(child: Container( // 박스 위젯
                                        width: double.infinity, height: double.infinity, // 가로, 세로 무제한
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 좌 10 상 5 우 10 하 5의 여백을 줌
                                          child: ElevatedButton( // 버튼 위젯
                                            onPressed: () async { // 버튼 클릭 시 회원탈퇴가 진행되고 회원탈퇴가 완료되면 로그인 페이지로 돌아간다.
                                              if (Delete_inputEmail.text == '' || Delete_inputPassword.text == ''){ // 만약 공백이 있을 시
                                                showDialog( // 팝업 화면을 띄움
                                                  context: context,
                                                  barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                                                  builder: (context) {
                                                    return Dialog( // Dialog 위젯 사용
                                                      child: Container( // 상자 위젯
                                                        width: 150, height: 150, // 가로와 세로 150
                                                        child: Column( // 세로 정렬
                                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                          children: [
                                                            Expanded(child: Container( // 상자 위젯
                                                              alignment: Alignment.center, // 가운데 정렬
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Text('공백없이 입력해주세요.',
                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) // 볼드체, 크기 16
                                                            ), flex: 2),
                                                            Expanded(child: Container( // 상자 위젯
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                                child: ElevatedButton( // 버튼 위젯
                                                                  onPressed: (){
                                                                    Navigator.pop(context);
                                                                    Delete_inputEmail.clear();
                                                                    Delete_inputPassword.clear();
                                                                  },
                                                                  child: Text('확인')
                                                                ),
                                                              )
                                                            ), flex: 1)
                                                          ]
                                                        )
                                                      )
                                                    );
                                                  }
                                                );
                                              } else if (widget.userEmail != Delete_inputEmail.text){ // 만약 현재 로그인한 사용자의 이메일과 입력한 이메일이 일치하지 않으면
                                                showDialog( // 팝업 화면을 띄움
                                                  context: context,
                                                  barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                                                  builder: (context) {
                                                    return Dialog( // Dialog 위젯 사용
                                                      child: Container( // 상자 위젯
                                                        width: 150, height: 150, // 가로와 세로 150
                                                        child: Column( // 세로 정렬
                                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                          children: [
                                                            Expanded(child: Container( // 상자 위젯
                                                              alignment: Alignment.center, // 가운데 정렬
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Text('로그인한 아이디와 일치하지 않습니다.',
                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) // 볼드체, 크기 16
                                                            ), flex: 2),
                                                            Expanded(child: Container( // 상자 위젯
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                                child: ElevatedButton( // 버튼 위젯
                                                                  onPressed: (){
                                                                    Navigator.pop(context);
                                                                    Delete_inputEmail.clear();
                                                                    Delete_inputPassword.clear();
                                                                  },
                                                                  child: Text('확인')
                                                                ),
                                                              )
                                                            ), flex: 1)
                                                          ]
                                                        )
                                                      )
                                                    );
                                                  }
                                                );
                                              } else if(widget.userEmail == Delete_inputEmail.text){ // 만약 현재 로그인한 사용자의 이메일과 입력한 이메일이 일치한다면
                                                // 일치하는 아이디의 이메일과 비밀번호 정보를 데이터베이스에서 불러올 것임
                                                final Delete_response =
                                                    await http.get(Uri.parse('http://www.teamtoktok.kro.kr/회원탈퇴.php?id=' + Delete_inputEmail.text + '&password=' + Delete_inputPassword.text));
                                                // 문서... Url로 접근한 것의 body에 접근할 것임
                                                dom.Document document = parse.parse(Delete_response.body);

                                                // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter_Framework에 알려주는 역할이다.
                                                // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
                                                setState(() {
                                                  // php문서에서 className이 deleteprofile 아래에 있는 정보들을 가져와서 Delete_msg에 저장
                                                  final Delete_msg = document.getElementsByClassName('deleteprofile');
                                                  // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
                                                  getInfo = Delete_msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();
                                                  // getInfo 배열의 0번째 index 값의 문자열 중 <td> & </td>를 제외한 나머지 값을 가져올 것임
                                                  getAll = getInfo[0].replaceAll(RegExp('(<td>|</td>)'), '');

                                                  if(getInfo[0].contains('회원탈퇴가 완료되었습니다.')){ // 만약 비밀번호가 일치하면
                                                    showDialog( // 팝업 화면을 띄움
                                                      context: context,
                                                      barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                                                      builder: (context) {
                                                        return Dialog( // Dialog 위젯 사용
                                                          child: Container( // 상자 위젯
                                                            width: 150, height: 150, // 가로와 세로 150
                                                            child: Column( // 세로 정렬
                                                              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                              children: [
                                                                Expanded(child: Container( // 상자 위젯
                                                                  alignment: Alignment.center, // 가운데 정렬
                                                                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                  child: Text('회원탈퇴가 완료되었습니다.',
                                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) // 볼드체, 크기 16
                                                                ), flex: 2),
                                                                Expanded(child: Container( // 상자 위젯
                                                                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                  child: Padding(
                                                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                                    child: ElevatedButton( // 버튼 위젯
                                                                      onPressed: (){
                                                                        Delete_inputEmail.clear();
                                                                        Delete_inputPassword.clear();
                                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_page()), (route) => false);
                                                                      },
                                                                      child: Text('확인')
                                                                    ),
                                                                  )
                                                                ), flex: 1)
                                                              ]
                                                            )
                                                          )
                                                        );
                                                      }
                                                    );
                                                  }
                                                });
                                              }
                                              if(getInfo[0].contains('비밀번호가 일치하지 않습니다.')){ // 만약 비밀번호가 일치하지 않으면
                                                showDialog( // 팝업 화면을 띄움
                                                  context: context,
                                                  barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                                                  builder: (context) {
                                                    return Dialog( // Dialog 위젯 사용
                                                      child: Container( // 상자 위젯
                                                        width: 150, height: 150, // 가로와 세로 150
                                                        child: Column( // 세로 정렬
                                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                          children: [
                                                            Expanded(child: Container( // 상자 위젯
                                                              alignment: Alignment.center, // 가운데 정렬
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Text('비밀번호가 일치하지 않습니다.',
                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) // 볼드체, 크기 16
                                                            ), flex: 2),
                                                            Expanded(child: Container( // 상자 위젯
                                                              width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                                child: ElevatedButton( // 버튼 위젯
                                                                  onPressed: (){
                                                                    Delete_inputEmail.clear();
                                                                    Delete_inputPassword.clear();
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
                                                  }
                                                );
                                              }
                                            },
                                            child: Text('확인')
                                          ),
                                        )
                                      ), flex: 3)
                                    ]
                                  )
                                )
                              );
                            }
                          );
                        },
                        child: Text('회원탈퇴', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)) // 볼드체, 색상은 빨강
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_page()),(route) => false);
                        },
                        child: Text('로그아웃', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
      ),
      bottomNavigationBar: BottomAppBar( // 하단 바
        child: Container( // 상자 위젯
          height: 60, // 높이 60
          child: Row( // 가로 정렬
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
            children: [
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg), (route) => false); // 친구 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.person_outline) // 친구 목록 아이콘
              ),
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/chatList', arguments: ChatList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg), (route) => false); // 채팅 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.chat_bubble_outline) // 채팅 목록 아이콘
              ),
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg), (route) => false); // 게시글 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.list_alt) // 게시글 목록 아이콘
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.segment, color: Colors.blue)
              )
            ]
          )
        )
      )
    );
  }
}

