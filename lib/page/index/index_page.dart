import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redis_mobile_client/model/conn_info.dart';
import 'package:redis_mobile_client/widgets/conn_info_card/conn_info_card.dart';
import 'package:redis_mobile_client/widgets/input_list/input_list.dart';

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
    List<TextEditingController> _controllers = List.generate(4, (i) => TextEditingController());
    List<String> _labels = ["Name", "IP", "Port", "Password"];
    confirmAction() {

      String? name = _controllers[0].text.trim();
      name = name.isEmpty ? null : name;

      String ip = _controllers[1].text.trim();

      // todo: catch not number
      String? portStr = _controllers[2].text.trim();
      int port = portStr.isEmpty ? 6379 : int.parse(portStr);

      String? pwd = _controllers[3].text.trim();
      pwd = pwd.isEmpty ? null : pwd;

      ConnectionInfo.addSharedConn(ConnectionInfo(ip, connectionName: name, connectionPort: port, connectionPwd: pwd));
      Navigator.of(context).pop(true);
    }

    return showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Add Connection"),
        content: InputList(_labels, _controllers),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: confirmAction
          ),
        ],
      );
    });
  }
}