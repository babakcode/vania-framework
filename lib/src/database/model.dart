import 'package:eloquent/eloquent.dart';
import 'package:vania/vania.dart';

class Model {
  String? _table;
  Connection _connection() {
    DatabaseDriver? driver = Config().get('database')?.driver;
    if (driver == null) {
      throw Exception('Database driver not found');
    }
    return driver.connection;
  }

  void table(String table) {
    _table = table;
  }

  QueryBuilder query() {
    try {
      return _connection().table(_table!);
    } on InvalidArgumentException catch (e) {
      Logger.log(e.cause.toString(), type: Logger.ERROR);
      rethrow;
    }
  }
}
