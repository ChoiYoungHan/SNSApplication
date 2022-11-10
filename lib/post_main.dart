import 'package:application_20221022/post.dart';
import 'package:flutter/material.dart';

class post_Main extends StatelessWidget {
  post_Main({Key? key, required this.post_Data}) : super(key: key);

  final post post_Data;

  static List<String> comment_writeName = ['Choiyounghan', 'Leeeunsoo'];
  static List<String> comment_writeTime = ['2분전', '1시간 전'];
  static List<String> comment_writeImage = ['assets/Choiyounghan.png', 'assets/Leeeunsoo.png'];
  static List<String> comment = ['사진이 멋있네요', '캬~'];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 채팅바 올라올 때 화면 밀림 방지
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(post_Data.friendName, style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: GestureDetector(
          child: Container(
            width: double.infinity, height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Container(
                          width: double.infinity, height: double.infinity,
                          child: Row(
                            children: [
                              Expanded(child: Container(
                                width: double.infinity, height: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.asset(post_Data.friendImage)
                                  )
                                )
                              ), flex: 2),
                              Expanded(child: Container(
                                width: double.infinity, height: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(child: Container(
                                      width: double.infinity, height: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Text(post_Data.friendName,
                                            style: TextStyle(fontWeight: FontWeight.bold))),
                                          Expanded(child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: null,
                                                icon: Icon(Icons.more_horiz)
                                              )
                                            )
                                          ))
                                        ]
                                      )
                                    ), flex: 1),
                                    Expanded(child: Container(
                                      width: double.infinity, height: double.infinity,
                                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      child: Text(post_Data.postTime, style: TextStyle(
                                       color: Colors.grey, fontSize: 12
                                      ))
                                    ), flex: 1)
                                  ]
                                )
                              ), flex: 11)
                            ]
                          )
                        ), flex: 1),
                        Expanded(child: Container(
                          width: double.infinity, height: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(post_Data.postContents)
                          )
                        ), flex: 2),
                        Expanded(child: Container(
                          width: double.infinity, height: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Image.asset(post_Data.postImage, fit: BoxFit.cover)
                          )
                        ), flex: 5)
                      ]
                    )
                  )
                ), flex: 7),
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity,
                  child: ListView.builder(
                    itemCount: comment_writeName.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          width: double.infinity, height: 70,
                          child: Card(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Image.asset(comment_writeImage[index], fit: BoxFit.cover)
                                    )
                                  )
                                ), flex: 2),
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(comment_writeName[index], style: TextStyle(fontWeight: FontWeight.bold)),
                                              Padding(padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                                child: Text(comment_writeTime[index],
                                                style: TextStyle(fontSize: 11, color: Colors.grey)))
                                            ]
                                          )
                                        )
                                      ), flex: 1),
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: Text(comment[index])
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
                Expanded(child: Container(
                  width: double.infinity, height: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: double.infinity, height: double.infinity,
                        child: TextField(
                          decoration: InputDecoration(hintText: '댓글을 입력해주세요.')
                        )
                      ), flex: 8),
                      Expanded(child: Container(
                        width: double.infinity, height: double.infinity,
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(Icons.send, color: Colors.blue)
                        )
                      ), flex: 2)
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
