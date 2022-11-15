import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_back, color: Colors.black)
        )
      ),
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
                        hintText: '비밀번호를 입력해주세요..',
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
                      ElevatedButton(onPressed: null, child: Text('회원가입')),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            Email = inputEmail.text;
                            Password = inputPassword.text;
                          });
                          await http.get(Uri.parse(
                              'http://www.teamtoktok.kro.kr/회원가입.php?id=' + Email + '&password= ' + Password + '&name=0&message=0&image=0&phone=0&birthday=0'));
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
