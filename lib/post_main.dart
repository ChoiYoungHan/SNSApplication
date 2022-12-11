import 'package:application_20221022/comment.dart';
import 'package:application_20221022/post_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class PostMain_UserEmail{ // 로그인 한 유저의 정보와 게시글의 postUID 값을 받아와 저장할 class 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;
  final String readPostUID;
  final String readPostID;
  final String readPostUserImage;
  final String readPostImage;
  final String readPostName;
  final String readPostContents;
  final String readPostTime;
  
  
  PostMain_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg, required this.readPostUID, required this.readPostID, required this.readPostUserImage, required this.readPostImage, required this.readPostName, required this.readPostContents, required this.readPostTime});
}

class postMain extends StatelessWidget {
  const postMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PostMain_UserEmail 클래스의 인자값을 받아오겠다.
    final usEmail = ModalRoute.of(context)?.settings.arguments as PostMain_UserEmail;
    
    return MaterialApp(
      routes: {
        '/postList' : (context) => post_List(), // post_List 페이지로 값을 넘겨주기 위한 선언
        '/postMain' : (context) => postMain() // postMain 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: PostMainPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg, readPostUID: usEmail.readPostUID, readPostID: usEmail.readPostID, readPostUserImage: usEmail.readPostUserImage, readPostImage: usEmail.readPostImage, readPostName: usEmail.readPostName, readPostContents: usEmail.readPostContents, readPostTime: usEmail.readPostTime)
    );
  }
}

class PostMainPage extends StatefulWidget {
  const PostMainPage({Key? key, this.userEmail, this.userName, this.userStateMsg, this.readPostUID, this.readPostID, this.readPostUserImage, this.readPostImage, this.readPostName, this.readPostContents, this.readPostTime}) : super(key: key);
  final userEmail, userName, userStateMsg, readPostUID, readPostID, readPostUserImage, readPostImage, readPostName, readPostContents, readPostTime;
  
  @override
  State<PostMainPage> createState() => _PostMainPageState();
}

class _PostMainPageState extends State<PostMainPage> {
  
  // 데이터리스트 배열
  static List<String> commentNum = [];
  static List<String> commentUID = [];
  static List<String> commentImage = []; // 댓글 작성자 이미지
  static List<String> commentName = []; // 댓글 작성자 이름
  static List<String> commentContents = []; // 댓글 내용
  static List<String> commentTime = []; // 댓글 작성 시간
  
  // 읽어들인 각각의 인덱스 값을 저장할 변수
  String Com_Read_Num = '', Com_Read_UID = '', Com_Read_Image = '', Com_Read_Name = '', Com_Read_Contents = '', Com_Read_Time = '';
  
  // 읽어들인 문자열을 저장할 변수
  String Com_Read_All = '';
  
  // 읽어들인 것을 저장할 배열
  static List<String> Com_Read_Info = [];
  
  // 구분자로 나누어 각각의 나눈 값을 삽입할 배열
  static List<String> Com_Split_Info = [];

  // 댓글을 입력할 텍스트 필드
  TextEditingController inputComment = TextEditingController();
  
  void initState(){
    getCommentInfo();
  }
  
  void getCommentInfo() async {
    // 혹시라도 배열에 값이 들어있는 것을 방지하기 위해 비워줌
    commentNum.clear();
    commentUID.clear();
    commentImage.clear();
    commentName.clear();
    commentContents.clear();
    commentTime.clear();
    
    // 댓글을 검색하기 위한 Url 실행
    final Com_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/게시글선택.php?postuid=' + widget.readPostUID));
    
    // Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(Com_response.body);
    
    // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할
    // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
    setState(() {
      // php 문서에서 className이 post 아래에 있는 정보들을 가져와서 Com_Msg 변수에 저장
      final Com_Msg = document.getElementsByClassName('post');
      
      // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
      Com_Read_Info = Com_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();
      
      // Com_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td> & <br>를 제거함
      Com_Read_All = Com_Read_Info[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');
      
      // Com_Read_All 의 값을 구분자 '///'로 나누어 배열에 저장함
      Com_Read_Info = Com_Read_All.split('///');
      
      // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
      for(int i = 0; i < Com_Read_Info.length - 1; i++){
        // Com_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어 배열에 집어넣음
        Com_Split_Info = Com_Read_Info[i].split('::');
        
        // 각 배열의 인덱스 값을 문자열에 저장해줌
        Com_Read_Num = Com_Split_Info[0];
        Com_Read_UID = Com_Split_Info[1];
        Com_Read_Image = Com_Split_Info[2];
        Com_Read_Name = Com_Split_Info[3];
        Com_Read_Contents = Com_Split_Info[4];
        Com_Read_Time = Com_Split_Info[5];
        
        // 문자열을 각자의 배열에 넣음
        commentNum.add(Com_Read_Num.toString());
        commentUID.add(Com_Read_UID.toString());
        commentImage.add(Com_Read_Image.toString());
        commentName.add(Com_Read_Name.toString());
        commentContents.add(Com_Read_Contents.toString());
        commentTime.add(Com_Read_Time.toString());
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    // List.generate는 length의 길이만큼 0부터 index - 1 까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
    final List<Comment> commentData = List.generate(commentUID.length, (index) => 
        Comment(commentNum[index], commentUID[index], commentImage[index], commentName[index], commentContents[index], commentTime[index]));
   
    return Scaffold(
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때 화면 밀림 방지
      appBar: AppBar( // 상단 바
        backgroundColor: Colors.white, // 배경색은 흰색
        leading: IconButton( // 왼쪽 정렬, 아이콘 버튼 위젯
          onPressed: (){
            Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 버튼, 색상은 회색
        ),
        title: Text(widget.readPostName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20)) // 볼드체, 크기 20, 색상은 회색
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 상자 위젯
            width: double.infinity, height: double.infinity, // 가로와 세로 무제한
            child: Column( // 세로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Card( // 네 모서리가 둥글다는 특징이 있음
                    child: Column( //세로 정렬
                      mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                      children: [
                        Expanded(child: Container( // 상자 위젯
                          width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                          child: Row( // 가로 정렬
                            mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                            children: [
                              Expanded(child: Container( // 상자 위젯
                                width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                child: Padding( // 여백을 주고 싶을 때 사용하는 위젯
                                  padding: EdgeInsets.fromLTRB(8,2,8,2), // 왼 8 위 2 우 8 아래 2의 여백을 줌
                                  child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용하는 위젯
                                    borderRadius: BorderRadius.circular(35), // 각진 부분을 35만큼 둥글게
                                    child: Image.network('http://' + widget.readPostUserImage, fit: BoxFit.cover) // 이미지를 가득 채움
                                  ),
                                )
                              ), flex: 2),
                              Expanded(child: Container( // 상자 위젯
                                width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                child: Column( // 세로 정렬
                                  mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                  children: [
                                    Expanded(child: Container( // 상자 위젯
                                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                      child: Row( // 가로 정렬
                                        mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                        children: [
                                          Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 2), // 위3, 아래 2의 여백
                                            child: Text(widget.readPostName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), // 볼드체
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0), // 우 5의 여백을 줌
                                                child: Align( // 정렬하고 싶을 때 사용하는 위젯
                                                  alignment: Alignment.centerRight, // 가운데 우측 정렬
                                                  child:
                                                  widget.userEmail == widget.readPostID ?
                                                  IconButton(
                                                    onPressed: (){
                                                      showDialog(useRootNavigator: false, context: context, builder: (context){
                                                        return Dialog( // Dialog 위젯
                                                          child: Container( // 상자 위젯
                                                            width: 150, height: 150, // 가로와 세로 150
                                                            child: Column( // 세로 정렬
                                                              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                              children: [
                                                                Expanded(child: Container( // 상자 위젯
                                                                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                  alignment: Alignment.center, // 가운데 정렬
                                                                  child: Text('정말 게시글을 삭제하시겠습니까?', style: TextStyle(fontWeight: FontWeight.bold)) // 볼드체
                                                                ), flex: 7),
                                                                Expanded(child: Container( // 상자 위젯
                                                                  child: Row( // 가로 정렬
                                                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                                    children: [
                                                                      Expanded(child: Container( // 상자 위젯
                                                                        padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                                                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                        child: ElevatedButton( // 버튼 위젯
                                                                          onPressed: (){
                                                                            Navigator.pop(context); // 팝업창 닫음
                                                                          },
                                                                          child: Text('취소')
                                                                        ),
                                                                      ), flex: 1),
                                                                      Expanded(child: Container( // 상자 위젯
                                                                        padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                                                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                        child: ElevatedButton( // 버튼 위젯
                                                                          onPressed: () async {
                                                                            Navigator.pop(context);
                                                                            showDialog(barrierDismissible: false, useRootNavigator: false, context: context, builder: (context){
                                                                              return Dialog( // Dialog 위젯
                                                                                child: Container( // 상자 위젯
                                                                                  width: 150, height: 130, // 가로 150, 세로 130
                                                                                  child: Column( // 세로 정렬
                                                                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                                                                      children: [
                                                                                        Expanded(child: Container( // 상자 위젯
                                                                                          alignment: Alignment.center, // 가운데 정렬
                                                                                          width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                                                                          child: Text('게시글 삭제가 완료되었습니다.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)) // 볼드체, 크기 16
                                                                                        ), flex: 2),
                                                                                        Expanded(child: Container( // 상자 위젯
                                                                                          padding: EdgeInsets.all(10), // 모든 면의 여백을 10만큼 줌
                                                                                          child: ElevatedButton( // 버튼 위젯
                                                                                            onPressed: () async {
                                                                                              Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                                                                                              await http.get(Uri.parse('http://www.teamtoktok.kro.kr/게시글삭제.php?id=' + widget.userEmail + '&postuid=' + widget.readPostUID));
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
                                                                            child: Text('확인')
                                                                        ),
                                                                      ), flex: 1)
                                                                    ]
                                                                  )
                                                                ), flex: 3)
                                                              ]
                                                            )
                                                          )
                                                        );
                                                      });
                                                    },
                                                    icon: Icon(Icons.delete, color: Colors.grey)
                                                  ) : null
                                                )
                                              ))
                                        ]
                                      )
                                    ), flex: 2),
                                    Expanded(child: Container( // 상자 위젯
                                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // 위 2의 여백을 줌
                                      child: Text(widget.readPostTime, style: TextStyle(fontSize: 12, color: Colors.grey)) // 크기 12, 색상 회색
                                    ), flex: 1)
                                  ]
                                )
                              ), flex: 11)
                            ]
                          )
                        ), flex: 1),
                        Expanded(child: Container( // 상자 위젯
                          width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                          child: Padding( // 여백을 주기 위해 사용하는 위젯
                            padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                            child: Text(widget.readPostContents)
                          )
                        ), flex: 2),
                        Expanded(child: Container( // 상자 위젯
                          width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                          child: Padding( // 여백을 주기 위해 사용하는 위젯
                            padding: EdgeInsets.all(3), // 모든 면의 여백을 3만큼 줌
                            child: Image.network('http://' + widget.readPostImage, fit: BoxFit.cover) // 이미지를 꽉 채움
                          ),
                        ), flex: 5)
                      ]
                    )
                  )
                ), flex: 7),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: ListView.builder(
                    itemCount: commentUID.length,
                    itemBuilder: (context, index){
                      return GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
                        child: Container( // 상자 위젯
                          width: double.infinity, height: 60, // 가로 무제한 세로 60
                          child: Card( // Card 위젯, 모서리가 둥글다는 특징이 있음
                            child: Row( // 가로 정렬
                              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                              children: [
                                Expanded(child: Container( // 상자 위젯
                                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                  child: Padding( // 여백을 주기 위해 사용하는 위젯
                                    padding: EdgeInsets.fromLTRB(8, 2, 8, 2), // 왼 8 위 2 우 8 아래 2의 여백을 줌
                                    child: ClipRRect( // 네모의 각진 부분을 둥글게 하기 위해 사용하는 위젯
                                      borderRadius: BorderRadius.circular(35), // 각진 부분을 35만큼의 여백을 줌
                                      child: Image.network('http://' + commentData[index].CommentImage, fit: BoxFit.cover) // 이미지를 꽉 채움
                                    )
                                  )
                                ), flex: 2),
                                Expanded(child: Container( // 상자 위젯
                                  width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
                                  child: Column( // 세로 정렬
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Padding( // 여백을 주기 위해 사용하는 위젯
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0), // 위에 5만큼 여백 줌
                                        child: Container( // 상자 위젯
                                          width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                          child: Row( // 가로 정렬
                                            mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                            children: [
                                              Text(commentData[index].CommentName, style: TextStyle(fontWeight: FontWeight.bold)), // 볼드체
                                              Padding(padding: EdgeInsets.fromLTRB(3, 0, 0, 0), // 왼 3의 여백을 줌
                                                child: Text(commentData[index].CommentTime,
                                                style: TextStyle(fontSize: 11, color: Colors.grey))) // 사이즈 11, 색상은 회색
                                            ]
                                          )
                                        )
                                      ), flex: 1),
                                      Expanded(child: Container( // 상자 위젯
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        child: Text(commentData[index].CommentContents)
                                      ), flex: 1)
                                    ]
                                  )
                                ), flex: 9)
                              ]
                            )
                          )
                        )
                      );
                    })
                ), flex: 3),
                Expanded(child: Container( // 상자 위젯
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: Row( // 가로정렬
                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                    children: [
                      Expanded(child: Container( // 상자 위젯
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼 10의 여백을 줌
                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                        child: TextField( // 텍스트 필드 위젯
                          controller: inputComment, // 입력받은 값으 변수 inputComment에 저장
                          decoration: InputDecoration(hintText: '댓글을 입력해주세요.'),
                        )
                      ), flex: 8),
                      Expanded(child: Container( // 상자 위젯
                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                        child: IconButton( // 아이콘 버튼 위젯
                          onPressed: () async {
                            if (inputComment.text == ''){

                            } else {
                              await http.get(Uri.parse('http://www.teamtoktok.kro.kr/댓글작성.php?id=' + widget.userEmail + '&postuid=' + widget.readPostUID.trim() + '&comment=' + inputComment.text));
                              inputComment.clear();
                              Navigator.pushNamed(context, '/postMain', arguments: PostMain_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg, readPostUID: widget.readPostUID, readPostID: widget.readPostID, readPostUserImage: widget.readPostUserImage, readPostImage: widget.readPostImage, readPostName: widget.readPostName, readPostContents: widget.readPostContents, readPostTime: widget.readPostTime));
                            }
                          },
                          icon: Icon(Icons.send, color: Colors.blue) // 보내기 아이콘
                        ),
                      ))
                    ]
                  )
                ), flex: 1)
              ]
            )
          )
        )
      )
    );
  }
}
