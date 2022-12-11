import 'package:application_20221022/post.dart';
import 'package:application_20221022/post_list.dart';
import 'package:application_20221022/post_main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class PostSearch_UserEmail{ // 로그인한 유저의 정보를 받아와 저장할 클래스 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  PostSearch_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class postSearch extends StatelessWidget {
  const postSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PostSearch_UserEmail 클래스의 인자값을 받아오겠다.
    final usEmail = ModalRoute.of(context)?.settings.arguments as PostSearch_UserEmail;

    return MaterialApp(
      routes: {
        '/postList' : (context) => post_List(), // post_List 페이지로 값을 넘겨주기 위한 선언
        '/postMain' : (context) => postMain() // postMain 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: PostSearchPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class PostSearchPage extends StatefulWidget {
  const PostSearchPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<PostSearchPage> createState() => _PostSearchPageState();
}

class _PostSearchPageState extends State<PostSearchPage> {

  // 게시글을 검색할 때 입력받을 텍스트 필드
  TextEditingController inputPost = TextEditingController();

  // 데이터 리스트 배열
  static List<String> postUID = []; // 게시글의 UID
  static List<String> postID = []; // 작성자 아이디
  static List<String> postUserImage = []; // 작성자의 이미지
  static List<String> postImage = []; // 게시글의 이미지
  static List<String> postName = []; // 작성자 이름
  static List<String> postContents = []; // 작성 내용
  static List<String> postTime = []; // 게시물 작성 시간

  // 읽어들인 각각의 인덱스 값을 저장할 변수
  String Post_Read_UID = '', Post_Read_ID = '', Post_Read_UserImage = '', Post_Read_Image = '', Post_Read_Name = '', Post_Read_Contents = '', Post_Read_Time = '';

  // 읽어들인 문자열을 저장할 변수
  String Post_Read_All = '';

  // 읽어들인 것을 저장할 배열
  static List<String> Post_Read_Info = [];

  // 구분자로 나누어 각각의 나눈 값을 삽입할 배열
  static List<String> Post_Split_info = [];

  void initState(){
    // 기존의 배열에 아무것도 들어있지 않게 비워둠
    postUID.clear();
    postID.clear();
    postUserImage.clear();
    postImage.clear();
    postName.clear();
    postContents.clear();
    postTime.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 상중하로 나누는 위젯
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경은 흰색
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/postList', arguments: PostList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey)
        ),
        title: Text('게시글 검색', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey))
      ),
      body: SafeArea( // MediaQuery 를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 상자 위젯
            width: double.infinity, height: double.infinity, // 가로와 세로 무제한
            child: Column( // 세로 정렬
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 1.5,
                      color: Colors.grey
                    ))
                  ),
                  width: double.infinity, height: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: inputPost,
                          decoration: InputDecoration(
                            hintText: '게시글 이름이나 내용을 입력해주세요.'
                          )
                        )
                      ), flex: 8),
                      Expanded(child: IconButton(
                        onPressed: () async {
                          if(inputPost.text == ''){
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
                                          child: Text('공백없이 입력해주세요.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
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
                                        ),
                                      ), flex: 1)
                                    ]
                                  )
                                )
                              );
                            });
                          } else {
                            // 기존의 배열에 아무것도 들어있지 않게 비워줌
                            postUID.clear();
                            postID.clear();
                            postUserImage.clear();
                            postImage.clear();
                            postName.clear();
                            postContents.clear();
                            postTime.clear();

                            // 게시글을 검색하기 위해 Url 실행
                            final Post_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/게시판.php?user1=' + widget.userEmail + '&user2name=' + inputPost.text));

                            // Url의 body에 접근을 할 것임
                            dom.Document document = parse.parse(Post_response.body);

                            // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할이다.
                            // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
                            setState(() {
                              // php 문서에서 classname이 post 아래에 있는 정보들을 가져와서 Post_Msg 변수에 저장
                              final Post_Msg = document.getElementsByClassName('post');

                              // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
                              Post_Read_Info = Post_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

                              // Post_Read_Info 배열의 0번째 index 값의 문자열 중, <td> & </td> & <br>를 제거함
                              Post_Read_All = Post_Read_Info[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');

                              // Post_Read_All의 값을 구분자 '///'로 나누어 배열에 저장
                              Post_Read_Info = Post_Read_All.split('///');

                              // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
                              for(int i = 0; i < Post_Read_Info.length - 1; i++){
                                // Post_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어 배열에 집어넣음
                                Post_Split_info = Post_Read_Info[i].split('::');

                                // 각 배열의 인덱스 값을 문자열에 저장해줌
                                Post_Read_UID = Post_Split_info[0];
                                Post_Read_ID = Post_Split_info[1];
                                Post_Read_UserImage = Post_Split_info[2];
                                Post_Read_Image = Post_Split_info[3];
                                Post_Read_Name = Post_Split_info[4];
                                Post_Read_Contents = Post_Split_info[5];
                                Post_Read_Time = Post_Split_info[6];

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
                        },
                        icon: Icon(Icons.search, color: Colors.grey)
                      ), flex: 1)
                    ]
                  )
                ),
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity,
                  child: ListView.builder(
                    itemCount: postID.length,
                    itemBuilder: (context, index){
                      
                      // List.generate는 length의 길이만큼 0부터 index -1 까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
                      final List<post> postData = List.generate(postID.length, (index) => 
                          post(postUID[index], postID[index], postUserImage[index], postImage[index], postName[index], postContents[index], postTime[index]));
                      
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/postMain', arguments: PostMain_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg, readPostUID: postData[index].postUID, readPostID: postData[index].postID, readPostUserImage: postData[index].postUserImage, readPostImage: postData[index].postImage, readPostName: postData[index].postName, readPostContents: postData[index].postContents, readPostTime: postData[index].postTime));
                        },
                        child: Container(
                          width: double.infinity, height: 450,
                          padding: EdgeInsets.all(5),
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      width: 1.5,
                                      color: Colors.grey
                                    ))
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.all(3),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(35),
                                            child: Image.asset(postData[index].postUserImage, fit: BoxFit.cover)
                                          )
                                        )
                                      ), flex:  2),
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(child: Container(
                                              padding: EdgeInsets.fromLTRB(3, 6, 0, 0),
                                              width: double.infinity, height: double.infinity,
                                              child: Text(postData[index].postName, style: TextStyle(fontWeight: FontWeight.bold))
                                            ), flex: 1),
                                            Expanded(child: Container(
                                              width: double.infinity, height: double.infinity,
                                              padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                              child: Text(postData[index].postTime, style: TextStyle(color: Colors.grey))
                                            ), flex: 1)
                                          ]
                                        )
                                      ), flex: 11)
                                    ]
                                  )
                                ), flex: 1),
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  child: Text(postData[index].postContents)
                                ), flex: 2),
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  child: Image.asset(postData[index].postImage, fit: BoxFit.cover)
                                ), flex: 5)
                              ]
                            ) 
                          )  
                        )
                      );
                    }),
                ))
              ]
            )
          )
        )
      )
    );
  }
}
