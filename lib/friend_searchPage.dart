import 'package:flutter/material.dart';

class FindUser extends StatelessWidget {
  const FindUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FindUserPage()
    );
  }
}

class FindUserPage extends StatefulWidget {
  const FindUserPage({Key? key}) : super(key: key);

  @override
  State<FindUserPage> createState() => _FindUserPageState();
}

class _FindUserPageState extends State<FindUserPage> {

  // 친구 이름을 검색할 텍스트 필드
  TextEditingController inputFriendName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때 화면 밀림을 방지
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            // 친구목록 페이지로 갈것임 & 로그인 한 사용자의 정보를 넘겨줘야 함
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
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10), // 왼 10, 위 0, 우 5, 아래 10의 여백을 줌
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
                        onPressed: (){},
                        icon: Icon(Icons.search, size: 30) // 검색 아이콘, 크기는 30
                      ), flex: 1)
                    ]
                  )
                ),
                Expanded(
                  child: Container(
                    width: double.infinity, height: double.infinity, // 가로, 세로 무제한
                    child: ListView.builder( // 리스트뷰 위젯
                      itemCount: 5,
                      itemBuilder: (context, index){
                        return GestureDetector( // Container와 같이 Gesture를 감지할 수 없는 위젯들에게 Gesture 기능을 부여할 수 있는 위젯
                          onTap: (){ // 한 번 클릭 시 friend_profilescreen으로 넘어가게 해 줄 것임. 값 전달 필요

                          },
                          onLongPress: (){ // 길게 누를 시, 친구목록 화면과 같이 구현

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
                                        child: Image.asset('assets/Ahnhyunsoo.png', width: 100, height: 100, fit: BoxFit.cover) // 이미지 삽입, 이미지는 최대로
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
                                            child: Text('이름이 출력될 부분',
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), maxLines: 1)
                                            // 텍스트의 사이즈 20, 볼드체, 색상은 검정, 최대 라인수 1
                                          )
                                        ), flex: 1),
                                        Expanded(child: Padding( // 여백을 줄 때 사용하는 위젯
                                          padding: EdgeInsets.all(5), // 모든 면의 여백을 5만큼 줌
                                          child: Container(
                                            width: double.infinity, height: double.infinity, // 가로와 세로를 무제한
                                            child: Text('유저의 상태메시지가 출력될 부분',
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
