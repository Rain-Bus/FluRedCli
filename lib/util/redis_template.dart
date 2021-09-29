import 'package:redis/redis.dart';

// todo: The client page is no time to dev better due to the deadline of google play's develop account expire date.
class RedisUtil {

}

class RedisClient {
  int? port;
  String ip;
  String? password;

  static RedisConnection? _connection;
  static Command? _command;

  RedisClient._(this.ip, this.port, {this.password});

  static Future<RedisClient> newInstance(String ip, {int? port = 6379, String? password}) async {
    RedisClient client = RedisClient._(ip, port, password: password);
    _connection = RedisConnection();
    _command = await _connection!.connect(ip, port);
    await _command!.send_object(["AUTH", password]);
    return client;
  }

  Future<String?> getString(String key) async {
    return await _command!.get(key);
  }

  setString(String key, String value) async {
    await _command!.send_object(["SET", key, value]);
  }

  Future<String> ping() async {
    return await _command!.send_object(["PING"]);
  }

  Future<dynamic> execute(String command) async {
    List commandObject = command.split(" ");
    return _command!.send_object(commandObject);
  }

}