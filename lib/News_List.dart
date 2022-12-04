import 'package:application_20221022/my_List.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

import 'News.dart';

class NewsList_UserEmail{ // 로그인한 사용자의 정보를 담아둘 클래스 객체 선언
  final String userEmail;
  final String userName;
  final String userStateMsg;

  NewsList_UserEmail({required this.userEmail, required this.userName, required this.userStateMsg});
}

class news_List extends StatelessWidget {
  const news_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NewsList_UserEmail 클래스의 인자값을 받아오기 위한 선언
    final usEmail = ModalRoute.of(context)?.settings.arguments as NewsList_UserEmail;

    return MaterialApp(
      routes: {
        '/myList': (context) => my_List() // my_List 페이지로 값을 넘겨주기 위한 선언
      },
      debugShowCheckedModeBanner: false,
      home: NewsListPage(userEmail: usEmail.userEmail, userName: usEmail.userName, userStateMsg: usEmail.userStateMsg)
    );
  }
}

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key, this.userEmail, this.userName, this.userStateMsg}) : super(key: key);
  final userEmail, userName, userStateMsg;

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {

  // 데이터리스트 배열
  static List<String> NewsUID = [];
  static List<String> NewsTitle = [];
  static List<String> NewsContents = [];
  static List<String> NewsTime = [];

  // 읽어들인 각각의 인덱스 값을 저장할 변수
  String News_Read_UID = '', News_Read_Title = '', News_Read_Contents = '', News_Read_Time = '';

  // 읽어들인 문자열을 저장할 변수
  String News_Read_All = '';

  // 읽어들인 것을 저장할 배열
  static List<String> News_Read_Info = [];

  // 구분자로 나누어 각각의 나눈 값을 삽입할 배열
  static List<String> News_Split_Info = [];

  void initState(){
    getNewsInfo();
  }

  void getNewsInfo() async {
    // 혹시라도 배열에 값이 들어있는 것을 방지하기 위해 비워줌
    NewsUID.clear();
    NewsTitle.clear();
    NewsContents.clear();
    NewsTime.clear();

    // 공지사항을 검색하기 위한 Url 실행
    final News_response = await http.get(Uri.parse('http://www.teamtoktok.kro.kr/공지사항.php?'));

    // Url의 body에 접근을 할 것임
    dom.Document document = parse.parse(News_response.body);

    // setState() 함수 안에서의 호출은 State에서 무언가 변경된 사항이 있음을 Flutter Framework에 알려주는 역할
    // 이로 인해 UI에 변경된 값이 반영될 수 있도록 build 메소드가 다시 실행된다.
    setState(() {
      // php문서에서 className이 notice 아래에 있는 정보들을 가져와서 News_Msg 변수에 저장
      final News_Msg = document.getElementsByClassName('notice');

      // TagName이 tr 아래에 있는 값들을 모두 가져와서 저장
      News_Read_Info = News_Msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

      // News_Read_Info 배열의 0번째 index 값의 문자열 중 <td> & </td> 를 제거함
      News_Read_All = News_Read_Info[0].replaceAll(RegExp('(<td>|</td>)'), '');

      // News_Read_All 의 값을 구분자 '///'로 나누어 배열에 저장함
      News_Read_Info = News_Read_All.split('///');

      // 마지막 배열은 비어있을 것이기에 배열의 마지막에서 -1을 해줌
      for(int i = 0; i < News_Read_Info.length - 1; i++){
        // News_Read_Info 배열의 각 인덱스에 들어있는 값을 구분자 '::'로 나누어 배열에 집어넣음
        News_Split_Info = News_Read_Info[i].split('::');

        // 각 배열의 인덱스 값을 문자열에 저장해줌
        News_Read_UID = News_Split_Info[0];
        News_Read_Title = News_Split_Info[1];
        News_Read_Contents = News_Split_Info[2];
        News_Read_Time = News_Split_Info[3];

        // 문자열을 각자의 배열에 삽입
        NewsUID.add(News_Read_UID.toString());
        NewsTitle.add(News_Read_Title.toString());
        NewsContents.add(News_Read_Contents.toString());
        NewsTime.add(News_Read_Time.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // List.generate는 length의 길이만큼 0 부터 index -1 까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성
    final List<News> newsData = List.generate(NewsUID.length, (index) =>
        News(NewsUID[index], NewsTitle[index], NewsContents[index], NewsTime[index]));

    return Scaffold( // 상중하로 나누는 위젯
      appBar: AppBar( // 상단바
        backgroundColor: Colors.white, // 배경색은 흰색
        leading: IconButton( // 아이콘 버튼 위젯
          onPressed: (){
            Navigator.pushNamed(context, '/myList', arguments: MyList_UserEmail(userEmail: widget.userEmail, userName: widget.userName, userStateMsg: widget.userStateMsg));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey) // 뒤로가기 버튼, 색상은 회색
        ),
        title: Text('공지사항', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)) // 글자의 두께를 줄임, 색상은 회색
      ),
      body: SafeArea( // MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시
        child: GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
          child: Container( // 상자 위젯
            width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
            child: Column(
              mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
              children: [
                Container( // 상자 위젯
                  width: double.infinity, height: 40, // 가로 무제한, 세로 40
                  child: Row( // 가로 정렬
                    mainAxisSize: MainAxisSize.max,  // 남은 영역을 모두 사용
                    children: [
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            ),
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            )
                          )
                        ),
                        height: 40, // 높이 40
                        alignment: Alignment.center, // 가운데 정렬
                        child: Text('번호', style: TextStyle(fontWeight: FontWeight.bold)) // 볼드체
                      ), flex: 1),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            ),
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            )
                          )
                        ),
                        height: 40, // 높이 40
                        alignment: Alignment.center, // 가운데 정렬
                        child: Text('제목', style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1) // 볼드체
                      ), flex: 3),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            ),
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            )
                          )
                        ),
                        height: 40, // 높이 40
                        alignment: Alignment.center, // 가운데 정렬
                        child: Text('내용', style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1) // 볼드체
                      ), flex: 3),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            ),
                            right: BorderSide(
                              color: Colors.grey,
                              width: 1.5
                            )
                          )
                        ),
                        height: 40, // 높이 40
                        alignment: Alignment.center, // 가운데 정렬
                        child: Text('날짜', style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1) // 볼드체
                      ), flex: 2)
                    ]
                  )
                ),
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                  child: ListView.builder(
                    itemCount: NewsUID.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        child: Container(
                          width: double.infinity, height: 40,
                          child: Row( // 가로 정렬
                            mainAxisSize: MainAxisSize.max,  // 남은 영역을 모두 사용
                            children: [
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    ),
                                    right: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    )
                                  )
                                ),
                                height: 40, // 높이 40
                                alignment: Alignment.center, // 가운데 정렬
                                child: Text(newsData[index].newsUID.trim(), style: TextStyle(fontWeight: FontWeight.bold)) // 볼드체
                              ), flex: 1),
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    ),
                                    right: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    )
                                  )
                                ),
                                height: 40, // 높이 40
                                alignment: Alignment.center, // 가운데 정렬
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                  child: Text(newsData[index].newsTitle, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                                ) // 볼드체
                              ), flex: 3),
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    ),
                                    right: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    )
                                  )
                                ),
                                height: 40, // 높이 40
                                alignment: Alignment.centerLeft, // 가운데 정렬
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                  child: Text(newsData[index].newsContents, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                                ) // 볼드체
                              ), flex: 3),
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    ),
                                    right: BorderSide(
                                      color: Colors.grey,
                                      width: 1.5
                                    )
                                  )
                                ),
                                height: 40, // 높이 40
                                alignment: Alignment.center, // 가운데 정렬
                                child: Text(newsData[index].newsTime, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1) // 볼드체
                              ), flex: 2)
                            ]
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
