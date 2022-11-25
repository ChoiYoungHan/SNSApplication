import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';

class MyList_UserEmail{ // 로그인한 사용자의 이메일 정보를 담아둘 클래스 객체 선언
  final String userEmail;

  MyList_UserEmail({required this.userEmail});
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
        '/postList' : (context) => post_List() // post_List 페이지로 값을 넘겨주기 위함
      },
      debugShowCheckedModeBanner: false,
      home: MyListPage(userEmail: usEmail.userEmail)
    );
  }
}

class MyListPage extends StatefulWidget {
  final userEmail;

  const MyListPage({Key? key, this.userEmail}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {

  static const routeName = '/myList'; // 값을 받기 위함

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상 중 하로 나누는 위젯
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
                            child: Image.asset('assets/Ahnhyunsoo.png', width: 100, height: 100, fit: BoxFit.cover) // 사진은 꽉 차게
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
                              child: Text('유저 이름', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)) // 볼드체, 사이즈 20
                            ),
                            Align( // 정렬할 때 사용하는 위젯
                              alignment: Alignment.centerLeft, // 가운데 왼쪽에 배치
                              child: Text('유저 상태메시지', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)) // 볼드체, 사이즈 16, 색상은 회색
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
                    onPressed: (){

                    },
                    child: Padding( // 여백을 주기 위해 사용하는 위젯
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                      child: Text('통화', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
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

                    },
                    child: Padding( // 여백을 주기 위해 사용하는 위젯
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                      child: Text('메시지 알림', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
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

                    },
                    child: Padding( // 여백을 주기 위해 사용하는 위젯
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10 위 0 아래 0 우 0의 여백을 줌
                      child: Text('앱 버전', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))) // 볼드체, 크기 16, 색상 검정
                  )
                ),
                Container(
                  alignment: Alignment.center, // 가운데 정렬
                  width: double.infinity, height: 50, // 가로 무제한, 세로 60
                  child: TextButton( // 텍스트 버튼 위젯
                    onPressed: (){

                    },
                    child: Text('회원탈퇴', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)) // 볼드체, 색상은 빨강
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
                  Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmail)); // 친구 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.person_outline) // 친구 목록 아이콘
              ),
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamed(context, '/chatList', arguments: ChatList_UserEmail(userEmail: widget.userEmail)); // 채팅 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.chat_bubble_outline) // 채팅 목록 아이콘
              ),
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail)); // 게시글 목록 페이지로 이동 및 인자값 전달
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

