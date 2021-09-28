import 'package:flutter/material.dart';

class ConnectionInfoCard extends StatefulWidget {

  final String? connectionName;
  final String connectionIp;
  final String? lastConnectTime;

  const ConnectionInfoCard(this.connectionIp, {this.lastConnectTime, this.connectionName, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionInfoCardState();

}

class _ConnectionInfoCardState extends State<ConnectionInfoCard> {

  String? _connectionName;
  String _connectionIp = "Null";
  String? _lastConnectTime;

  @override
  void initState() {
    super.initState();
    _connectionName = widget.connectionName;
    _connectionIp = widget.connectionIp;
    _lastConnectTime = widget.lastConnectTime;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Card(
            child: Column(
                children: [
                  ListTile(
                    title: Text(_connectionName ?? _connectionIp, style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                    subtitle: Text(_lastConnectTime == null ? "Never used" : "Last connected at: $_lastConnectTime"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(icon: const Icon(Icons.cable_outlined),
                        onPressed: () {},),
                      IconButton(icon: const Icon(Icons.edit_outlined),
                        onPressed: () {},),
                      IconButton(icon: const Icon(Icons.delete_outlined),
                        onPressed: () {},)
                    ],
                  )
                ]
            )
        )
    );
  }

}