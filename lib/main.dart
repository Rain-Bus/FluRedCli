import 'package:flutter/material.dart';
import 'package:redis_mobile_client/page/index/index_page.dart';
import 'package:redis_mobile_client/page/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluRedCli',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.red,
        backgroundColor: Colors.white
      ),
      home: const IndexPage()
    );
  }
}
