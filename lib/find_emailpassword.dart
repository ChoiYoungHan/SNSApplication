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

  // 입력한 값을 저장할 변수
  String findEm_ph = '', findEm_bi ='', findPa_em = '', findPa_ph = '', findPa_bi = '';

  var findEm_read_Message = <String>[];

  // split으로 나눠서 저장할 변수
  var findEmPa_Result = '', findEmPa_Value = '';

  String findEm_current_message = '', findPa_current_message = '';

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
                      onPressed: () async {
                        setState(() {
                          findEm_ph = findEmail_phone.text;
                          findEm_bi = findEmail_birthday.text;
                        });

                        final findEmPa_response =  await http.get(Uri.parse(
                          'http://www.teamtoktok.kro.kr/회원정보찾기.php?phone=' + findEm_ph + '&birthday=' + findEm_bi
                        ));

                        dom.Document document = parse.parse(findEmPa_response.body);

                        setState(() {
                          final findEm_msg = document.getElementsByClassName('profileinfo');

                          findEm_read_Message = findEm_msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

                          findEm_current_message = findEm_read_Message[0].replaceAll(RegExp('(<td>|</td>)'), '');

                          findEmPa_Result = findEm_current_message.split('::')[0];
                          findEmPa_Value = findEm_current_message.split('::')[1];

                          if(findEmPa_Result.contains('아이디 찾기에 성공했습니다.')){
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
                                        child: Text(findEmPa_Value,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                                      ), flex: 2),
                                      Expanded(child: Container(
                                        width: double.infinity, height: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            findEmail_phone.clear();
                                            findEmail_birthday.clear();
                                          },
                                          child: Text('확인')
                                        ),
                                      ), flex: 1)
                                    ]
                                  )
                                )
                              );
                            });
                          }
                        });
                      },
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
