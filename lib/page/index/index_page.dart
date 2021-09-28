import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redis_mobile_client/model/conn_info.dart';
import 'package:redis_mobile_client/widgets/conn_info_card/conn_info_card.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  // List<ConnectionInfoCard> cards = [];
  final ValueNotifier<List<ConnectionInfoCard>> cards = ValueNotifier<List<ConnectionInfoCard>>([]);

  void initData() async {
    getCards();
  }

  // Future<List<ConnectionInfoCard>> getCards() async {
  void getCards() async {
    cards.value = (await ConnectionInfo.getSharedConn())
        .map((conn) => ConnectionInfoCard(conn.connectionIp, lastConnectTime: conn.lastConnectedTime, connectionName: conn.connectionName))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("FluRedCli"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              onPressed: () async {
                var addSuccess = await showAddDialog() ?? false;
                if(addSuccess) {
                    await Future.delayed(const Duration(milliseconds: 500));
                    getCards();
                  }
                },
            ),
          ],
        ),
        body: ValueListenableBuilder<List<ConnectionInfoCard>>(
          valueListenable: cards,
          builder: (BuildContext context, List<ConnectionInfoCard> value, Widget? child) {
            return SingleChildScrollView(
              child: ListBody(
                children: cards.value,
              ),
            );
          },
        ),
      )
    );
  }

  Future<bool?> showAddDialog() {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _ipController = TextEditingController();
    TextEditingController _pwdController = TextEditingController();
    TextEditingController _portController = TextEditingController();
    TextEditingController _pController = TextEditingController();

    return showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Add Connection"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Connection Name(Optional)"
                ),
              ),
              Container(
                height: 4,
              ),
              TextField(
                controller: _ipController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Connection Ip"
                ),
              ),
              Container(
                height: 4,
              ),
              TextField(
                controller: _pwdController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                ),
              ),
            ],
          )
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: () async {
              // todo: judge null
              String? name = _nameController.text.trim();
              name = name == "" ? null : name;
              String ip = _ipController.text.trim();
              ConnectionInfo.addSharedConn(ConnectionInfo(ip, connectionName: name));
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    });
  }
}