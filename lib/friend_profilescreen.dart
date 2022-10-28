import 'package:flutter/material.dart';

class friend_profilescreen extends StatelessWidget {
  const friend_profilescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profile_Screen()
    );
  }
}

class profile_Screen extends StatelessWidget {
  const profile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 텍스트 출력에 오류가 있을때는 Scaffold로 감싸주면 해결된다.
      body: Container( // Stack을 넣어줌
        width: double.infinity, height: double.infinity,
        child: Stack(
          children: [
            Image.asset('assets/sky.jpg', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
            Container(
              width: double.infinity, height: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0x00FFFFFF)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Container(
                    width: double.infinity, height: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                        border: Border(bottom: BorderSide(
                            width: 1,
                            color: Color(0xffC6C8C6)
                        ))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Container(
                          width: double.infinity, height: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0x00FFFFFF)
                          ),
                        ), flex: 6),
                        Expanded(child: Container(
                          width: double.infinity, height: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0x00FFFFFF)
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(child: Container(
                                padding: EdgeInsets.fromLTRB(0, 85, 0, 0),
                                width: 100, height: 100,
                                decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                    borderRadius: BorderRadius.circular(45)
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: Image.asset('assets/sky.jpg', width: 100, height: 100, fit: BoxFit.cover)
                                ),
                              ), flex: 2),
                              Expanded(child: Container(
                                  alignment: Alignment.center,
                                  child: Text('최영한', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600))
                              ), flex: 1)
                            ],
                          ),
                        ), flex: 4)
                      ],
                    ),
                  ), flex: 8),
                  Expanded(child: Material(
                    color: Color(0x00FFFFFF),
                    child: Container(
                      width: double.infinity, height: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0x00FFFFFF)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              constraints: BoxConstraints(), // IConButton의 패딩을 없애주기 위한 작업
                              onPressed: null,
                              icon: Icon(Icons.drive_file_rename_outline_rounded, size: 40, color: Colors.white)),
                          IconButton(
                              constraints: BoxConstraints(), // IConButton의 패딩을 없애주기 위한 작업
                              onPressed: null,
                              icon: Icon(Icons.chat_bubble, size: 40, color: Colors.white)),
                          IconButton(
                              constraints: BoxConstraints(), // IConButton의 패딩을 없애주기 위한 작업
                              onPressed: null,
                              icon: Icon(Icons.call, size: 40, color: Colors.white)),
                          IconButton(
                              constraints: BoxConstraints(), // IConButton의 패딩을 없애주기 위한 작업
                              onPressed: null,
                              icon: Icon(Icons.list_alt, size: 40, color: Colors.white)),
                        ],
                      ),
                    ),
                  ), flex: 2)
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

