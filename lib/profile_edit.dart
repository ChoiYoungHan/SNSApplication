import 'package:application_20221022/my_List.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'my_List.dart';

class ProfileEdit_UserEmil{ // 로그인한 사용자의 정보를 담아둘 클래스 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;
  
  ProfileEdit_UserEmil({required this.userEmail, required this.userName, required this.userStateMsg});
}

class profile_edit extends StatelessWidget {
  const profile_edit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ProfileEdit_UserEmail 클래스의 인자값을 가져오기 위한 선언
    final usEmail = ModalRoute.of(context)?.settings.arguments as ProfileEdit_UserEmil;

    return MaterialApp(
      routes: {
        'myList' : (context) => my_List() // my_List 페이지로 값을 넘겨주기 위함
      },
      debugShowCheckedModeBanner: false,
      home: ProfileEditPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

  // 프로필 이름, 상태메시지 변경 시 입력한 이름과 상태메시지 값을 저장할 변수
  TextEditingController inputName = TextEditingController();
  TextEditingController inputStateMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상중하로 나눔
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때의 화면 밀림 방지
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경색은 흰색
        leading: IconButton( // 아이콘 버튼 위젯
          onPressed: (){
            Navigator.pushNamed(context, 'myList', arguments: MyList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 버튼, 색상은 회색
        ),
        title: Text('프로필 편집', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)) // 두께를 줄이고 색상은 회색
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 상자 위젯
            child: Column( // 세로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide( // 아래 테두리에 색을 줌
                      width: 1.5,
                      color: Colors.grey
                    ))
                  ),
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.all(10), // 모든 면의 여백을 10만큼 줌
                    child: ElevatedButton( // 버튼 위젯
                      onPressed: (){

                      },
                      child: Text('이미지 변경', style: TextStyle(color: Colors.black, fontSize: 16)) // 블랙, 16 사이즈
                    )
                  )
                ), flex: 2),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.fromLTRB(10, 4, 0, 0), // 왼 10 위 4의 여백을 줌
                    child: Text('이름 변경', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                  ) // 볼드체, 검정, 20사이즈
                ), flex: 1),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0), // 좌 10 우 10의 여백을 줌
                    child: TextField( // 텍스트 필드 위젯
                      controller: inputName, // 텍스트 필드에 입력된 값을 inputName 변수에 저장
                      decoration: InputDecoration(
                        hintText: '변경할 이름을 입력해주세요.'
                      ),
                    ),
                  ),
                ), flex: 1),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 좌 10 상 5 우 10 하 5의 여백을 줌 
                    child: ElevatedButton( // 버튼 위젯
                      onPressed: () async {
                        if(inputName.text == ''){
                          showDialog( // 팝업 화면을 띄우기 위함
                            context: context,
                            builder: (context){
                              return Dialog( // Dialog 위젯
                                child: Container( // 상자 위젯
                                  width: 150, height: 150, // 가로와 세로 150
                                  child: Column( // 세로 정렬
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container( // 상자 위젯
                                        alignment: Alignment.center, // 글자가 가운데 오도록 정렬
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: Text('공백없이 입력해주세요.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체 16
                                      ), flex: 2),
                                      Expanded(child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 좌 10 상 5 우 10 하 5 의 여백을 줌
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text('확인')
                                        ),
                                      ), flex: 1)
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                        } else {
                          await http.get(Uri.parse('http://www.teamtoktok.kro.kr/내이름변경.php?user1=' + widget.userEmail + '&Nickname=' + inputName.text));

                          showDialog( // 팝업 화면을 띄우기 위함
                            context: context,
                            builder: (context){
                              return Dialog( // Dialog 위젯
                                child: Container( // 상자 위젯
                                  width: 150, height: 150, // 가로와 세로 150
                                  child: Column( // 세로 정렬
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container( // 상자 위젯
                                        alignment: Alignment.center, // 글자가 가운데 오도록 정렬
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: Text('닉네임이 변경되었습니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체 16
                                      ), flex: 2),
                                      Expanded(child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 좌 10 상 5 우 10 하 5의 여백을 줌
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            inputName.clear();
                                          },
                                          child: Text('확인')
                                        ),
                                      ), flex: 1)
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                        }
                      },
                      child: Text('이름 변경', style: TextStyle(color: Colors.black, fontSize: 16)) // 검정색, 16 사이즈
                    ),
                  )
                ), flex: 1),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.fromLTRB(10, 4, 0, 0), // 좌 10 상 4의 여백을 줌
                    child: Text('상태메시지 변경', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                  ) // 볼드체, 검정색, 20 사이즈
                ), flex: 1),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0), // 좌 10 우 10의 여백을 줌
                    child: TextField( // 텍스트 필드 위젯
                      controller: inputStateMsg, // 텍스트 필드에 입력된 입력값을 inputStateMsg 변수에 저장
                      decoration: InputDecoration(
                        hintText: '변경할 상태메시지를 입력해주세요.'
                      )
                    ),
                  )
                ), flex: 1),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 좌 10 상 5 우 10 하 5의 여백을 줌
                    child: ElevatedButton(
                      onPressed: () async {
                          await http.get(Uri.parse('http://www.teamtoktok.kro.kr/상태메세지변경.php?user=' + widget.userEmail + '&statemessage=' + inputStateMsg.text));

                          showDialog( // 팝업 화면을 띄우기 위함
                            context: context,
                            builder: (context){
                              return Dialog( // Dialog 위젯
                                child: Container( // 상자 위젯
                                  width: 150, height: 150, // 가로와 세로 150
                                  child: Column( // 세로 정렬
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container( // 상자 위젯
                                        alignment: Alignment.center, // 글자가 가운데 오도록 정렬
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: Text('상태메시지가 변경되었습니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체 16
                                      ), flex: 2),
                                      Expanded(child: Container(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5), // 좌 10 상 5 우 10 하 5의 여백을 줌
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            inputStateMsg.clear();
                                          },
                                          child: Text('확인')
                                        ),
                                      ), flex: 1)
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                      },
                      child: Text('상태메시지 변경', style: TextStyle(color: Colors.black, fontSize: 16)) // 검정색, 16 사이즈
                    ),
                  )
                ), flex: 1),
                Expanded(child: Container(

                ), flex: 3)
              ]
            )
          )
        )
      ),
      bottomNavigationBar: BottomAppBar(

      )
    );
  }
}
