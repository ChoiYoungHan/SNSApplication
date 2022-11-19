import 'package:application_20221022/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class find_emailpassword extends StatelessWidget {
  const find_emailpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: find_email_password()
    );
  }
}

class find_email_password extends StatefulWidget {
  const find_email_password({Key? key}) : super(key: key);

  @override
  State<find_email_password> createState() => _find_email_passwordState();
}

class _find_email_passwordState extends State<find_email_password> {

  TextEditingController findEmail_phone = TextEditingController();
  TextEditingController findEmail_birthday = TextEditingController();
  TextEditingController findPassword_email = TextEditingController();
  TextEditingController findPassword_phone = TextEditingController();
  TextEditingController findPassword_birthday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => login_page()));
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey)
        ),
        title: Text('이메일/비밀번호 찾기')
      ),
      body: SafeArea(
        child: GestureDetector(
          child: Container(
            width: double.infinity, height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 7),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('이메일 찾기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: TextField(
                      controller: findEmail_phone,
                      decoration: InputDecoration(
                        hintText: ('전화번호를 입력해주세요.'),
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
                            color: Color(0xffC7C8C6)
                          )
                        )
                      )
                    )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: TextField(
                      controller: findEmail_birthday,
                      decoration: InputDecoration(
                        hintText: ('생일을 입력해주세요. ex)19990710'),
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
                        )),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color(0xffC6C8C6)
                          )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color(0xffC7C8C6)
                          )
                        )
                      ),
                    )),
                  Container(
                    width: double.infinity, height: 50,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text('이메일 찾기'))
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('비밀번호 찾기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: TextField(
                      controller: findPassword_email,
                      decoration: InputDecoration(
                        hintText: ('이메일을 입력해주세요.'),
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
                            color: Color(0xffC7C8C6)
                          )
                        )
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: TextField(
                      controller: findPassword_phone,
                      decoration: InputDecoration(
                        hintText: ('전화번호를 입력해주세요.'),
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
                            color: Color(0xffC7C8C6)
                          )
                        )
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: TextField(
                      controller: findPassword_birthday,
                      decoration: InputDecoration(
                        hintText: ('생일을 입력해주세요. ex)19990710'),
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
                            color: Color(0xffC7C8C6)
                          )
                        )
                      ),
                    )
                  ),
                  Container(
                    width: double.infinity, height: 50,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text('비밀번호 찾기'))
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
