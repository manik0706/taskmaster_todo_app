import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');

    _database = await openDatabase(
      path,
      version: 2, // Increased version to handle migration
      onCreate: _createDB,
      onUpgrade: _upgradeDB, // Added upgrade handler
    );

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        details TEXT,
        isCompleted INTEGER NOT NULL,
        dueDate TEXT
      )
    ''');
  }

  // Handle database migration for existing users
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE todos ADD COLUMN dueDate TEXT');
    }
  }

  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final result = await db.query('todos');
    return result.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}