import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo.dart';

class TodoSqlite {
  final String tableName = 'MY_DB_TB';
  late Database db;

  Future initDb() async {
    db = await openDatabase('my_db.db');
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT)',
    );
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    List<Map> maps = await db.query(
      tableName,
      columns: ['id', 'title', 'description'],
    );
    for (var map in maps) {
      todos.add(Todo.fromMap(map));
    }
    return todos;
  }

  Future<Todo?> getTodo(int id) async {
    List<Map> map = await db.query(
      tableName,
      columns: ['id', 'title', 'description'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return Todo.fromMap(map[0]);
    }
    return null;
  }

  Future<int> addTodo(Todo td) async {
    int id = await db.insert(tableName, td.toMap());
    return id;
  }

  Future updateTodo(Todo td) async {
    await db.update(tableName, td.toMap(), where: 'id = ?', whereArgs: [td.id]);
  }

  Future deleteTodo(int id) async {
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
