import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 앱 구동시켜 달라는 의미 // runApp 안에 메인페이지를 입력해줌
}

// stless 하고 탭 누른 다음 MyApp 입력해주면 메인 페이지 세팅은 끝
// 코드는 Widget build의 return 뒤에 작성할 것임
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
