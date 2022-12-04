import 'package:application_20221022/my_List.dart';
import 'package:flutter/material.dart';

class AppVersion_UserEmail { // 로그인한 유저의 정보를 받아와 담아둘 class 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  AppVersion_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class appversion extends StatelessWidget {
  const appversion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppVersion_UserEmail 클래스의 인자값을 받아오기 위함
    final usEmail = ModalRoute.of(context)?.settings.arguments as AppVersion_UserEmail;

    return MaterialApp(
      routes: {
        '/myList' : (context) => my_List() // my_List 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: AppVersionPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class AppVersionPage extends StatefulWidget {
  const AppVersionPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<AppVersionPage> createState() => _AppVersionPageState();
}

class _AppVersionPageState extends State<AppVersionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상중하로 나누는 위젯
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경색은 흰색
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/myList', arguments: MyList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 버튼, 색상은 회색
        ),
        title: Text('앱 버전 정보', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)) // 두께를 줄임, 회색
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: Container( // 상자 위젯
          alignment: Alignment.center, // 가운데 정렬
          padding: EdgeInsets.fromLTRB(0, 0, 0, 70), // 아래 70의 여백을 줌
          child: Text('ver 1.0.0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.grey)) // 볼드체, 크기 50, 회색
        )
      )
    );
  }
}
