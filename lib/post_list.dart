import 'package:application_20221022/AddPost.dart';
import 'package:application_20221022/chat_List.dart';
import 'package:application_20221022/my_List.dart';
import 'package:application_20221022/post.dart';
import 'package:application_20221022/post_list.dart';
import 'package:application_20221022/post_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

import 'main.dart';

class PostList_UserEmail{ // 로그인한 유저의 정보를 받아와 저장할 class 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  PostList_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}


class post_List extends StatelessWidget {
  const post_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PostList_UserEmail 클래스의 인자값을 받아오기 위함
    final usEmail = ModalRoute.of(context)?.settings.arguments as PostList_UserEmail;

    return MaterialApp(
        routes: {
          '/friendList' : (context) => MyApp(), // MyApp 페이지로 값을 넘겨주기 위한 선언
          '/chatList' : (context) => chat_List(), // chat_List 페이지로 값을 넘겨주기 위한 선언
          '/myList' : (context) => my_List(), // my_List 페이지로 값을 넘겨주기 위한 선언
          '/postMain' : (context) => postMain(), // postMain 페이지로 값을 넘겨주기 위한 선언
          '/addPost' : (context) => add_Post() // add_Post 페이지로 값을 넘겨주기 위한 선언
        },
        debugShowCheckedModeBanner: false,
        home: PostListPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {

  // 데이터 리스트 배열
  static List<String> postUID = []; // 게시글의 UID
  static List<String> postID = []; // 작성자 아이디
  static List<String> postUserImage = []; // 작성자의 이미지
  static List<String> postImage = []; // 게시글의 이미지
  static List<String> postName = []; // 작성자 이름
  static List<String> postContents = []; // 작성 내용
  static List<String> postTime = []; // 게시글 작성 시간

  // 읽어들인 각각의 인덱스 값을 저장할 변수
  String Post_Read_UID = '', Post_Read_ID = '', Post_Read_UserImage = '', Post_Read_Image = '', Post_Read_Name = '', Post_Read_Contents = '', Post_Read_Time = '';

  // 읽어들인 문자열을 저장할 변수
  String Post_Read_All = '';

  // 읽어들인 것을 저장할 배열
  static List<String> Post_Read_Info = [];

  // 구분자로 나누어 각각의 나눈 값을 삽입할 배열
  static List<String> Post_Split_Info = [];

  void initState(){
    getPostInfo();
  }

  void getPostInfo() async {
    // 혹시라도 배열에 값이 들어있는 것을 방지하기 위해 비워줌
    postUID.clear();
    postID.clear();
    postUserImage.clear();
    postImage.clear();
    postName.clear();
    postContents.clear();
    postTime.clear();

    // 게시글 목록을 검색하기 위한 Url 실행
    final Post_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/게시판.php?user1=' + widget.userEmail));

    // Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(Post_response.body);

    // setState() 함수 안에서의 호출은 State 에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할
    // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
    setState(() {
      // php 문서에서 className이 post 아래에 있는 정보들을 가져와서 Post_Msg 변수에 저장
      final Post_Msg = document.getElementsByClassName('post');

      // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
      Post_Read_Info = Post_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

      // Post_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td> & <br>를 제거함
      Post_Read_All = Post_Read_Info[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');

      // Post_Read_All 의 값을 구분자 '///'로 나누어 배열에 저장함
      Post_Read_Info = Post_Read_All.split('///');

      // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
      for(int i = 0; i < Post_Read_Info.length - 1; i++){
        // Post_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어 배열에 집어넣음
        Post_Split_Info = Post_Read_Info[i].split('::');

        // 각 배열의 인덱스 값을 문자열에 저장 해줌
        Post_Read_UID = Post_Split_Info[0];
        Post_Read_ID = Post_Split_Info[1];
        Post_Read_UserImage = Post_Split_Info[2];
        Post_Read_Image = Post_Split_Info[3];
        Post_Read_Name = Post_Split_Info[4];
        Post_Read_Contents = Post_Split_Info[5];
        Post_Read_Time = Post_Split_Info[6];

        // 문자열을 각자의 배열에 삽입
        postUID.add(Post_Read_UID.toString());
        postID.add(Post_Read_ID.toString());
        postUserImage.add(Post_Read_UserImage.toString());
        postImage.add(Post_Read_Image.toString());
        postName.add(Post_Read_Name.toString());
        postContents.add(Post_Read_Contents.toString());
        postTime.add(Post_Read_Time.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // List.generate는 length의 길이만큼 0부터 index - 1까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
    final List<post> postData = List.generate(postUID.length, (index) =>
        post(postUID[index], postID[index], postUserImage[index], postImage[index], postName[index], postContents[index], postTime[index]));

    return Scaffold( // 상 중 하로 나누는 위젯
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경은 흰색
        title: Text('게시글', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)), // 글자두께 줄이고 색상은 회색
        actions: [ // 상단바의 우측에 정렬
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.search, color: Colors.grey) // 검색 아이콘, 색상은 회색
          ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/addPost', arguments: AddPost_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
            },
            icon: Icon(Icons.add_circle_outline_outlined, color: Colors.grey) // 게시글 추가 아이콘, 색상은 회색
          )
        ]
      ),
      body: ListView.builder(
        itemCount: postUID.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){ // 한번 클릭 시
              Navigator.pushNamed(context, '/postMain', arguments: PostMain_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg, readPostUID: postData[index].postUID, readPostID: postData[index].postID, readPostUserImage: postData[index].postUserImage, readPostImage: postData[index].postImage, readPostName: postData[index].postName, readPostContents: postData[index].postContents, readPostTime: postData[index].postTime));
            },
            child: Container( // 상자 위젯
              width: double.infinity, height: 450, // 가로 무제한, 높이 450
              padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
              child: Card( // Card 위젯 ( 모서리가 둥글다는 특징이 있음 )
                child: Column( // 세로 정렬
                  mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                  children: [
                    Expanded(child: Container( // 상자 위젯
                      width: double.infinity, height: double.infinity, // 가로 세로 무제한
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide( // 상자 위젯의 아래 테두리에 색을 줌
                          width: 1.5,
                          color: Colors.grey
                        ))
                      ),
                      child: Row( // 가로 정렬
                        mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                        children: [
                          Expanded(child: Container( // 상자 위젯
                            width: double.infinity, height: double.infinity, // 가로 세로 무제한
                            child: Padding( // 여백을 주고 싶을 때 사요하는 위젯
                              padding: EdgeInsets.all(3), // 모든 면의 여백을 3만큼 줌
                              child: ClipRRect( // 네모의 각진 부분을 둥글게 하고 싶을 때 사용하는 위젯
                                borderRadius: BorderRadius.circular(35), // 각진 부분을 35만큼 둥글게
                                child: Image.asset(postData[index].postUserImage, width: 100, height: 100, fit: BoxFit.cover) // 이미지를 꽉 채우겠다
                              )
                            )
                          ), flex: 2),
                          Expanded(child: Container( // 상자 위젯
                            width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                            child: Column( // 세로 정렬
                              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                              children: [
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                  child: Row( // 가로 정렬
                                    mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                    children: [
                                      Expanded(child: Container( // 상자 위젯
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        padding: EdgeInsets.fromLTRB(3, 6, 0, 0), // 왼 3 위 6 우 0 아래 0 의 여백을 줌
                                        child: Text(postData[index].postName, style: TextStyle(fontWeight: FontWeight.bold)) // 볼드체
                                      ), flex: 3),
                                      Expanded(child: Container( // 상자 위젯
                                        width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                        padding: EdgeInsets.fromLTRB(0, 6, 3, 10), // 왼 0 위 6 우 3 아래 0의 여백을 줌
                                        child: Row( // 가로 정렬
                                          mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                          mainAxisAlignment: MainAxisAlignment.end, // 우측에 정렬
                                          children: [
                                            IconButton(
                                              onPressed: (){

                                              },
                                              icon: Icon(Icons.more_horiz, color: Colors.grey) // more_horiz 아이콘, 색상은 회색
                                            )
                                          ]
                                        )
                                      ), flex: 7)
                                    ]
                                  )
                                ), flex: 1),
                                Expanded(child: Container( // 상자 위젯
                                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0), // 왼 3의 여백을 줌
                                  child: Text(postData[index].postTime, style: TextStyle(color: Colors.grey)) // 시간 출력, 색상은 회색
                                ), flex: 1)
                              ]
                            )
                          ), flex: 11)
                        ]
                      )
                    ), flex: 1),
                    Expanded(child: Container( // 상자 위젯
                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                      padding: EdgeInsets.all(10), // 모든 면의 여백을 10만큼 줌
                      child: Text(postData[index].postContents) // 게시글 내용 출력
                    ), flex: 2),
                    Expanded(child: Container( // 상자 위젯
                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                      child: Image.asset(postData[index].postImage, width: 100, height: 100, fit: BoxFit.cover) // 이미지를 꽉 채움
                    ), flex: 5)
                  ]
                )
              ),
            )
          );
        }),
      bottomNavigationBar: BottomAppBar( // 하단 바
        child: Container( // 상자 위젯
          height: 60, // 높이 60
          child: Row( // 가로 정렬
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 간격을 두고 정렬
            children: [
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamed(context, '/friendList', arguments: FriendList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg)); // 친구 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.person_outline) // 친구 목록 아이콘
              ),
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){
                  Navigator.pushNamed(context, '/chatList', arguments: ChatList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg)); // 채팅 목록 페이지로 이동 및 인자값 전달
                },
                icon: Icon(Icons.chat_bubble_outline) // 채팅 목록 아이콘
              ),
              IconButton( // 아이콘 버튼 위젯
                onPressed: (){

                },
                icon: Icon(Icons.list_alt, color: Colors.blue) // 게시글 목록 아이콘
              ),
              IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/myList', arguments: MyList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
                },
                icon: Icon(Icons.segment)
              )
            ]
          )
        )
      )
    );
  }
}
