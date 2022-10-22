import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 앱 구동시켜 달라는 의미 // runApp 안에 메인페이지를 입력해줌
}

// Flutter에서 앱을 만드는 것은 위젯을 짜깁기 하는 것이라 보면 됨.
/*
Flutter에는 위젯이 4개가 있다.
글자 위젯, 이미지 위젯, 아이콘 위젯, 박스 위젯
 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Image.asset('Github_Image.jpg') // 이미지 위젯은 Image.asset('경로') 사용
      // 이미지를 사용할 때는 프로젝트 내에 이미지가 있어야함
      // 이미지 쓰겠다고 pubspec.yaml 아래의 flutter에 등록을 해줘야 함
      // assets 아래의 모든 파일을 가져다 쓰겠다.
    );
  }
}