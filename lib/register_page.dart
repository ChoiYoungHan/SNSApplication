import 'package:application_20221022/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class register_page extends StatelessWidget {
  const register_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: register()
    );
  }
}

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputBirthday = TextEditingController();

  String Email = ' ', Password = ' ', Name = ' ', Phone = ' ', Birthday = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: null, icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text('회원가입')
      ),
      body: SafeArea(
        child: GestureDetector(
          child: Container(
            width: double.infinity, height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset('assets/Ahnhyunsoo.png', fit: BoxFit.cover, width: 100, height: 100)
                  )),
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
                      )
                  ),
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
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: TextField(
                          controller: inputName,
                          decoration: InputDecoration(
                            hintText: '이름을 입력해주세요.',
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
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: TextField(
                          controller: inputPhone,
                          decoration: InputDecoration(
                            hintText: '전화번호를 입력해주세요.',
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
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: TextField(
                          controller: inputBirthday,
                          decoration: InputDecoration(
                            hintText: '생일을 입력해주세요.',
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
                  ElevatedButton(onPressed: () async {
                    setState(() {
                      Email = inputEmail.text;
                      Password = inputPassword.text;
                      Name = inputName.text;
                      Phone = inputPhone.text;
                      Birthday = inputBirthday.text;
                    });
                    await http.get(Uri.parse(
                        'http://www.teamtoktok.kro.kr/회원가입.php?id=' + Email + '&password=' + Password + '&name=' + Name + '&message=0&image=0&phone=' + Phone + '&birthday=' + Birthday));

                    if(inputEmail.text == ''){

                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => login_page()));
                    }

                    inputEmail.clear();
                    inputPassword.clear();
                    inputName.clear();
                    inputPhone.clear();
                    inputBirthday.clear();



                  }, child: Text('가입신청'))
                ]
              ),
            ),
          )
        )
      )
    );
  }
}

