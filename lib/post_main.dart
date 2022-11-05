import 'package:application_20221022/post.dart';
import 'package:flutter/material.dart';

class post_Main extends StatelessWidget {
  const post_Main({Key? key, required this.post_Data}) : super(key: key);

  final post post_Data;

  static List<String> comment_writeName = ['Choiyounghan'];
  static List<String> comment_writeTime = ['2분전'];
  static List<String> comment_writeImage = ['assets/Choiyounghan.png'];
  static List<String> comment = ['사진이 멋있네요'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_back)
        ),
        title: Text(post_Data.friendName, style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:[
            Container(
             width: double.infinity, height: 450,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Container(
                      width: double.infinity, height: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Container(
                            width: double.infinity, height: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.asset(post_Data.friendImage)
                              ),
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
                                      child: Text(post_Data.friendName)),
                                      Expanded(child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: null,
                                            icon: Icon(Icons.more_horiz)
                                          ),
                                        ),
                                      ))
                                    ]
                                  )
                                )),
                                Expanded(child: Container(
                                  width: double.infinity, height: double.infinity,
                                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  child: Text(post_Data.postTime, style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ))
                               ]
                              )
                            ), flex: 11)
                          ],
                        )
                      ), flex: 1),
                      Expanded(child: Container(
                        width: double.infinity, height: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(post_Data.postContents)
                        ),
                      ), flex: 2),
                      Expanded(child: Container(
                        width: double.infinity, height: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Image.asset(post_Data.postImage)
                        )
                      ), flex: 5)
                    ],
                  ),
                )
              ),
              ListView.builder(
                itemCount: post_Data.friendName.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    child: Container(
                      width: double.infinity, height: double.infinity,
                      padding: EdgeInsets.all(5),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(child: Container(
                              width: 100, height: 100,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.asset(comment_writeImage[index], width: 100, height: 100, fit: BoxFit.cover),
                                ),
                              ),
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
                                        Text(comment_writeName[index]),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                          child: Text(comment_writeTime[index]))
                                      ],
                                    ),
                                  ), flex: 1),
                                  Expanded(child: Container(
                                    width: double.infinity, height: double.infinity,
                                    child: Text(comment[index]),
                                  ), flex: 1)
                                ],
                              ),
                            ), flex: 9)
                          ],
                        )
                      )
                    )
                  );
                })
            ]
          )
       )
    );
  }
}
