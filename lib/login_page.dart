import 'package:application_20221022/register_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:fluttertoast/fluttertoast.dart'; // 토스트 메시지

import 'main.dart';

void main() => runApp(login());


class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_page()
    );
  }
}

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();

  String Email = '', Password = '';

  var Login_read_Message = <String>[];
  var Login_Read_id = '', Login_Read_email = '', Login_Read_password = '', Login_Read_name = '', Login_Read_message = '', Login_Read_image = '', Login_Read_phone = '', Login_Read_birthday = '';

  String Login_current_Message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          child: Container(
            width: double.infinity, height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(20, 50, 0, 15),
                  child: Text('환영합니다.', style: TextStyle(fontSize: 30))),
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                  child: TextField(
                    controller: inputEmail,
                    decoration: InputDecoration(
                      hintText: '이메일을 입력해주세요.',
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
                      ),
                    )
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: TextField(
                      controller: inputPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '비밀번호를 입력해주세요.',
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
                        ),
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: TextButton(
                      onPressed: null,
                      child: Text('이메일/비밀번호 찾기', style: TextStyle(color: Colors.blue))
                    )
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => register_page()));
                      }, child: Text('회원가입')),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            Email = inputEmail.text;
                            Password = inputPassword.text;
                          });

                          final Login_response = await http.get(Uri.parse(
                            'http://www.teamtoktok.kro.kr/로그인.php?id=' + Email + '&password=' + Password
                          ));

                          dom.Document document = parse.parse(Login_response.body);

                          setState(() {
                            final Login_msg = document.getElementsByClassName('logininfo');

                            Login_read_Message = Login_msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

                            Login_current_Message = Login_read_Message[0].replaceAll(RegExp('(<td>|</td>|<br>)'), '');

                            if(Login_read_Message[0].contains('일치하는 로그인 정보가 없습니다.')){
                              showDialog(context: context, builder: (context){return Dialog(
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(
                                            color: Color(0xffC6C8C6),
                                            width: 1.5
                                          ))
                                        ),
                                        alignment: Alignment.center,
                                        width: double.infinity, height: double.infinity,
                                        child: Text('일치하는 회원정보가 없습니다.',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ), flex: 2),
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            inputEmail.clear();
                                            inputPassword.clear();
                                          },
                                          child: Text('확인')
                                        )
                                      ), flex: 1)
                                    ]
                                  )
                                )
                              );});
                            } else if (inputEmail.text == '' || inputPassword.text == ''){
                              showDialog(context: context, builder: (context){
                                return Dialog(
                                  child: Container(
                                    width: 150, height: 150,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(
                                              color: Color(0xffC6C8C6),
                                              width: 1.5
                                            ))
                                          ),
                                          alignment: Alignment.center,
                                          width: double.infinity, height: double.infinity,
                                          child: Text('공백없이 입력해주세요.',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                                        ), flex: 2),
                                        Expanded(child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: Text('확인')
                                          )
                                        ), flex: 1)
                                      ]
                                    )
                                  )
                                );
                              });
                            } else {
                              Login_Read_id = Login_current_Message.split('::')[0];
                              Login_Read_email = Login_current_Message.split('::')[1];
                              Login_Read_password = Login_current_Message.split('::')[2];
                              Login_Read_name = Login_current_Message.split('::')[3];
                              Login_Read_message = Login_current_Message.split('::')[4];
                              Login_Read_image = Login_current_Message.split('::')[5];
                              Login_Read_phone = Login_current_Message.split('::')[6];
                              Login_Read_birthday = Login_current_Message.split('::')[7];

                              showDialog(context: context, builder: (context){
                                return Dialog(
                                  child: Container(
                                    width: 150, height: 150,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(
                                              color: Color(0xffC6C8C6),
                                              width: 1.5
                                            ))
                                          ),
                                          alignment: Alignment.center,
                                          width: double.infinity, height: double.infinity,
                                          child: Text('로그인에 성공하였습니다.',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                                          )
                                        ), flex: 2),
                                        Expanded(child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                              inputEmail.clear();
                                              inputPassword.clear();
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                                            },
                                            child: Text('확인')
                                          )
                                        ), flex: 1)
                                      ]
                                    )
                                  )
                                );
                              });
                            }
                          });
                        },
                        child: Text('로그인'))
                    ]
                  ))
                ]
              ),
            )
          )
        )
      )
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}


