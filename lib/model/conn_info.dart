import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ConnectionInfo {
  String? connectionName;
  String connectionIp = "";
  String? lastConnectedTime;
  String? connectionPwd;
  int connectionPort = 6379;

  ConnectionInfo(this.connectionIp, {this.connectionPwd, this.lastConnectedTime, this.connectionName, this.connectionPort = 6379});

  ConnectionInfo.fromJson(Map<String, dynamic> json) {
    connectionName = json["connectionName"];
    connectionIp = json["connectionIp"];
    lastConnectedTime = json["lastConnectedTime"];
    connectionPwd = json["connectionPwd"];
    connectionPort = json["connectionPort"];
  }

  static Map<String, dynamic> toJson(ConnectionInfo conn) {
    final Map<String, dynamic> map = {};
    map["connectionName"] = conn.connectionName;
    map["lastConnectedTime"] = conn.lastConnectedTime;
    map["connectionIp"] = conn.connectionIp;
    map["connectionPwd"] = conn.connectionPwd;
    map["connectionPort"] = conn.connectionPort;
    return map;
  }

  static List<Map<String, dynamic>> toJsonList(List<ConnectionInfo> connectionInfo) {
    return connectionInfo.map((conn) => toJson(conn)).toList();
  }

  static Future<List<ConnectionInfo>> getSharedConn() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    String? json = share.getString("connections");
    List<dynamic> decodeJson = json == null ? [] : jsonDecode(json);
    return decodeJson.map((connection) => ConnectionInfo.fromJson(connection)).toList();
  }

  static Future<bool> isIpExist(String ip) async {
    List<String> ipList = (await getSharedConn()).map((conn) => conn.connectionIp).toList();
    return ipList.contains(ip);
  }

  static void deleteSharedConn(String ip) async {
    List<ConnectionInfo> connList = await getSharedConn();
    connList.removeWhere((conn) => conn.connectionIp == ip);
    writeConnToShare(connList);
  }

  static void addSharedConn(ConnectionInfo conn) async {
    List<ConnectionInfo> connList = await getSharedConn();
    if(!await isIpExist(conn.connectionIp)) {
      connList.add(conn);
    }
    writeConnToShare(connList);
  }

  static void writeConnToShare(List<ConnectionInfo> connectionInfo) async {
    SharedPreferences share = await SharedPreferences.getInstance();
    share.setString("connections", jsonEncode(toJsonList(connectionInfo)));
  }

}