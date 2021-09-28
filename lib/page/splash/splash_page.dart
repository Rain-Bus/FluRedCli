import 'package:flutter/material.dart';
import 'package:redis_mobile_client/constant/constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // Future.delayed(new Duration(seconds: 1), () {
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        Constant.ASSETS_IMG + "frc_logo.png",
                        width: 120,
                      ),
                    ),
                    Image.asset(
                      Constant.ASSETS_IMG + "frc_full_name.png",
                      width: 250,
                    )
                  ]),
            ),
          ],
        )
    );
  }
}
