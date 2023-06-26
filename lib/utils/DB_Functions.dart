import 'package:teach_me/main.dart';

class DbFunctions{
  Future update(String table, String column, String condition, String value) async{
    var db = await initializeDatabase();
    await db.rawQuery('''UPDATE $table SET $column = $value WHERE $condition''');
  }
  Future get(String tableName, String condition) async{
    var db = await initializeDatabase();
    List records = await db.rawQuery('''SELECT * FROM $tableName WHERE $condition''');
    return records;
  }
}