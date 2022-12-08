import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class AddPost_UserEmail{ // 로그인 한 유저의 정보를 받아와 저장할 class 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  AddPost_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class add_Post extends StatelessWidget {
  const add_Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AddPost_UserEmail 클래스의 인자값을 받아온다.
    final usEmail = ModalRoute.of(context)?.settings.arguments as AddPost_UserEmail;

    return MaterialApp(
      routes: {
        '/postList' : (context) => post_List() // post_List 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: AddPostPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  // 게시글을 작성할 때의 텍스트 필드 변수
  TextEditingController inputContents = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때 화면 밀림 방지
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경색은 흰색
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 버튼
        ),
        title: Text('게시글 작성', style: TextStyle(color: Colors.grey)),
        actions: [
          IconButton(
            onPressed: () async {

              if(inputContents.text == ''){
                showDialog(context: context, builder: (context){
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
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
                await http.get(Uri.parse('http://www.teamtoktok.kro.kr/게시글쓰기.php?user=' + widget.userEmail + '&postimage=assets/sky.jpg&contents=' + inputContents.text));

                showDialog(useRootNavigator: false, context: context, builder: (context){
                  return Dialog(
                    child: Container(
                      width: 150, height: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(child: Container(
                              alignment: Alignment.center,
                              width: double.infinity, height: double.infinity,
                              child: Text('게시글 작성이 완료되었습니다.',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                            ), flex: 2),
                            Expanded(child: Container(
                              width: double.infinity, height: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: ElevatedButton(
                                  onPressed: (){
                                    inputContents.clear();
                                    Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
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

            },
            icon: Icon(Icons.upload, color: Colors.grey)
          )
        ]
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 상자 위젯
            width: double.infinity, height: double.infinity, // 가로와 세로 무제한
            child: Column( // 세로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: TextField(
                    maxLines: 10,
                    controller: inputContents,
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요.'
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, height: 50,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: (){

                    },
                    child: Text('이미지 첨부')
                  ),
                )
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