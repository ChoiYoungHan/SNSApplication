import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:image_picker/image_picker.dart';

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

  var Register_read_Message = <String>[];
  var Register_Read_id = '', Register_Read_email = '', Register_Read_password = '', Register_Read_name = '', Register_Read_message = '', Register_Read_image = '', Register_Read_phone = '', Register_Read_birthday = '';
  
  String Register_current_Message = '';

  File? _image;
  final picker = ImagePicker();

  late XFile pickedImage;

  Future<void> uploadQuery(XFile pickedImage, String Email) async {
    var uri = Uri.parse('http://www.teamtoktok.kro.kr/이미지.php?id=' + Email + '&mode=1');

    var request = http.MultipartRequest("POST", uri);
    var pic = await http.MultipartFile.fromPath('image', pickedImage.path);

    request.files.add(pic);

    var response = await request.send();

    if(response.statusCode == 200){
      print('image uploaded');
    } else {
      print('upload failed');
    }
  }

  // 비동기 처리를 통해 갤러리에서 이미지를 가져옴
  Future getImage(ImageSource imageSource) async {
    pickedImage = (await picker.pickImage(source: ImageSource.gallery))!;

    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      onPressed: () async {
        getImage(ImageSource.gallery);
      },
      child: Center(
        child: Image.file(File(_image!.path), fit: BoxFit.cover, width: 150, height: 150)));
  }

  @override
  Widget build(BuildContext context) {

    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => login_page()));
            },
          icon: Icon(Icons.arrow_back, color: Colors.black)),
        title: Text('회원가입', style: TextStyle(color: Colors.grey))
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
                    child: Container(
                      width: 100, height: 100,
                      child:
                        _image == null ?
                      IconButton(
                        onPressed: () async {
                          getImage(ImageSource.gallery);
                        },
                        icon: Icon(Icons.photo, color: Colors.grey, size: 50)
                      ) : showImage()
                    )
                  )),
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: TextField(
                        controller: inputEmail,
                          decoration: InputDecoration(
                            hintText: '아이디를 입력해주세요. (특수문자 제외)',
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
                            hintText: '생일을 입력해주세요. ex) 19990710',
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

                    final Register_response = await http.get(Uri.parse(
                        'http://www.teamtoktok.kro.kr/회원가입.php?id=' + Email + '&password=' + Password + '&name=' + Name + '&message=0&image=0&phone=' + Phone + '&birthday=' + Birthday));

                    dom.Document document = parse.parse(Register_response.body);

                    setState(() {
                      final Register_msg = document.getElementsByClassName('registerinfo');

                      Register_read_Message = Register_msg.map((element) => element.getElementsByTagName('tr')[0].innerHtml).toList();

                      Register_current_Message = Register_read_Message[0].replaceAll(RegExp('(<td>|</td>)'), '');

                      print(Register_current_Message);

                      if(inputEmail.text.contains('!') | inputEmail.text.contains('@') | inputEmail.text.contains('#') | inputEmail.text.contains('%') | inputEmail.text.contains('^') | inputEmail.text.contains('&') | inputEmail.text.contains('*') | inputEmail.text.contains('(') | inputEmail.text.contains(')') | inputEmail.text.contains('-') | inputEmail.text.contains('_') | inputEmail.text.contains('=') | inputEmail.text.contains('+') | inputEmail.text.contains('<') | inputEmail.text.contains('>') | inputEmail.text.contains('.') | inputEmail.text.contains('? ')){
                        showDialog(context: context, builder: (context){return Dialog(
                            child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity, height: double.infinity,
                                        child: Text('특수문자는 입력하실 수 없습니다.',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ), flex: 2),
                                      Expanded(child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text('확인')
                                            ),
                                          )
                                      ), flex: 1)
                                    ]
                                )
                            )
                        );});
                      } else if(Register_read_Message[0].contains('id가 이미 존재합니다.')){
                        showDialog(context: context, builder: (context){return Dialog(
                            child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity, height: double.infinity,
                                        child: Text('이미 존재하는 아이디입니다.',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ), flex: 2),
                                      Expanded(child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text('확인')
                                            ),
                                          )
                                      ), flex: 1)
                                    ]
                                )
                            )
                        );});
                      } else if(Register_read_Message[0].contains('phone이 이미 존재합니다.')){
                        showDialog(context: context, builder: (context){return Dialog(
                            child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity, height: double.infinity,
                                        child: Text('이미 존재하는 전화번호입니다.',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ), flex: 2),
                                      Expanded(child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text('확인')
                                            ),
                                          )
                                      ), flex: 1)
                                    ]
                                )
                            )
                        );});
                      } else if(inputEmail.text == '' || inputPassword.text == '' || inputName.text == '' || inputPhone.text == '' || inputBirthday.text == ''){
                        showDialog(context: context, builder: (context){return Dialog(
                            child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity, height: double.infinity,
                                        child: Text('공백없이 입력해주세요.',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ), flex: 2),
                                      Expanded(child: Container(
                                          width: double.infinity, height: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text('확인')
                                            ),
                                          )
                                      ), flex: 1)
                                    ]
                                )
                        )
                        );});
                      } else {
                        showDialog( // 팝업 화면을 띄움
                          context: context,
                          barrierDismissible: true, // 바깥 영역 터치 시 닫을지 여부
                          builder: (context) {
                            return Dialog( // Dialog 위젯 사용
                              child: Container( // 상자 위젯
                                width: 150, height: 150, // 가로와 세로 150
                                child: Column( // 세로 정렬
                                  mainAxisSize: MainAxisSize.max, // 남은 영역을 모두 사용
                                  children: [
                                    Expanded(child: Container( // 상자 위젯
                                      alignment: Alignment.center, // 가운데 정렬
                                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                      child: Text('회원가입에 성공하셨습니다.',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) // 볼드체, 크기 16
                                    ), flex: 2),
                                    Expanded(child: Container( // 상자 위젯
                                      width: double.infinity, height: double.infinity, // 가로와 세로 무제한
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: ElevatedButton( // 버튼 위젯
                                          onPressed: (){
                                            Navigator.pop(context);
                                            uploadQuery(pickedImage, Email);
                                          },
                                          child: Text('확인')
                                        ),
                                      )
                                    ), flex: 1)
                                  ]
                                )
                              )
                            );
                          }
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => login_page()));
                      }
                    });

                    inputEmail.clear();
                    inputPassword.clear();
                    inputName.clear();
                    inputPhone.clear();
                    inputBirthday.clear();

                  }, child: Text('가입신청')),
                ]
              ),
            ),
          )
        )
      )
    );
  }
}

