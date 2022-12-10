import 'package:application_20221022/chat_page.dart';
import 'package:application_20221022/main.dart';
import 'package:application_20221022/userPostSearch.dart';
import 'package:application_20221022/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class friend_profileScreen extends StatelessWidget {
  const friend_profileScreen({Key? key, required this.profile}) : super(key: key);

  final userProfile profile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/chatPage' : (context) => chatMain(),
        '/frinedList' : (context) => MyApp(),
        '/postUser' : (context) => UserPostSearch()
      },
      home: Scaffold(
          resizeToAvoidBottomInset: false, // 채팅바가 올라올 때 화면 밀림 방지
          body: GestureDetector(
              child: Container(
                width: double.infinity, height: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(profile.BackgroundImage, fit: BoxFit.cover),
                    Container(
                      width: double.infinity, height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Container(
                              width: double.infinity, height: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF)
                              )
                          ), flex: 2),
                          Expanded(child: Container(
                            width: double.infinity, height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0)
                                )
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(35),
                                          topRight: Radius.circular(35),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)
                                      )
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        width: double.infinity, height: 100,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(35),
                                              child: Image.asset(profile.userImage, fit: BoxFit.cover)
                                          ),
                                        ),
                                      ), flex: 3),
                                      Expanded(child: Container(
                                        width: double.infinity, height: 100,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(child: Padding(
                                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                child: Container(
                                                    width: double.infinity, height: double.infinity,
                                                    child: Text(profile.userName,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18
                                                        ))
                                                )
                                            ), flex: 1),
                                            Expanded(child: Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child: Container(
                                                  width: double.infinity, height: double.infinity,
                                                  child: Text(profile.userState, style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                      color: Color(0xffC6C8C6)
                                                  )),
                                                )
                                            ))
                                          ],
                                        ),
                                      ), flex: 8)
                                    ],
                                  ),
                                ), flex: 2),
                                Expanded(child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                      onPressed: () async {
                                        await http.get(Uri.parse('http://www.teamtoktok.kro.kr/채팅방만들기.php?user1=' + profile.LoginuserEmail + '&user2=' + profile.userEmail));

                                        Navigator.of(context, rootNavigator: false).popAndPushNamed('/chatPage', arguments: ChatPage_UserEmail(userEmail: profile.LoginuserEmail,  userName: profile.LoginuserName, userStateMsg: profile.LoginuserStateMsg, OtheruserEmail: profile.userEmail, OtheruserName: profile.userNickname));
                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(Icons.chat_bubble, size: 24, color: Colors.grey),
                                            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                child: Text('대화방', style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                                )))
                                          ]
                                      )
                                  ),
                                )),
                                Expanded(child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                      onPressed: () async {
                                        final url = Uri.parse('tel:' + profile.userPhone);
                                        launchUrl(url);
                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(Icons.call, size: 30, color: Colors.grey),
                                            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                child: Text('전화걸기', style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                                )))
                                          ]
                                      )
                                  ),
                                )),
                                Expanded(child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/postUser', arguments: UserPost_UserEmail(userEmail: profile.LoginuserEmail, userName: profile.LoginuserName, userStateMsg: profile.LoginuserStateMsg, postUser: profile.userEmail, postName: profile.userName));
                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(Icons.list_alt, size: 24, color: Colors.grey),
                                            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                child: Text('게시글', style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                                )))
                                          ]
                                      )
                                  ),
                                ))
                              ],
                            ),
                          ), flex: 2)
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.grey, size: 30)
                        )
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}