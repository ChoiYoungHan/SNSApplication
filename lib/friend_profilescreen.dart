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
    return Container( // Stack을 넣어줌
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
                              child: Text('이름', style: TextStyle(color: Colors.black))
                            ), flex: 1)
                          ],
                        ),
                      ), flex: 4)
                    ],
                  ),
                ), flex: 7),
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.drive_file_rename_outline),
                      Icon(Icons.chat_bubble_outline),
                      Icon(Icons.call_outlined),
                      Icon(Icons.list_alt_outlined)
                    ],
                  ),
                ), flex: 3)
              ],
            ),
          )
        ],
      ),
    );
  }
}

