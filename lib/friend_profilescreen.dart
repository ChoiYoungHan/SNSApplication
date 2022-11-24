import 'package:application_20221022/userProfile.dart';
import 'package:flutter/material.dart';

class friend_profileScreen extends StatelessWidget {
  const friend_profileScreen({Key? key, required this.profile}) : super(key: key);

  final userProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x1BC6C8C6))),
                                  onPressed: null,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(Icons.drive_file_rename_outline_rounded, size: 30),
                                      Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Text('이름 변경', style: TextStyle(
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
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x1BC6C8C6))),
                                    onPressed: null,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.chat_bubble, size: 24),
                                          Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                              child: Text('대화방', style: TextStyle(
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
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x1BC6C8C6))),
                                    onPressed: null,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.call, size: 30),
                                          Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                              child: Text('보이스톡', style: TextStyle(
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
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x1BC6C8C6))),
                                    onPressed: null,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.list_alt, size: 24),
                                          Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                              child: Text('게시글', style: TextStyle(
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
                  )
                ],
              ),
            )
        )
    );
  }
}

