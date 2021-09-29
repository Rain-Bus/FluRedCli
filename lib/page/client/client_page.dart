import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redis/redis.dart';
import 'package:redis_mobile_client/util/redis_template.dart';

class ClientPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String text = "";
  final TextEditingController _commandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){},
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: Center(
                child: SingleChildScrollView(child: Text(text)),
              ),
            ),
            TextField(
              controller: _commandController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: getVal
                )
              ),
            )
          ]
        )
      ),
    );
  }

  getVal() async {
    RedisConnection redis = RedisConnection();
    RedisClient client;
    try {
      client = await RedisClient.newInstance("myhost.fallen-angle.com", password: "wzl20001001");
    } on Exception {
      return null;
    }
    String res = (await client.execute(_commandController.text)).toString();
    print(res);
    setState(() {
      text = res;
    });
  }

}