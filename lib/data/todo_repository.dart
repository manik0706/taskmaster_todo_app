import '../models/todo.dart';
import 'todo_database.dart';

class TodoRepository {
  final db = TodoDatabase.instance;

  Future<List<Todo>> loadTodos() => db.getTodos();
  Future<void> addTodo(Todo todo) async => await db.insertTodo(todo);
  Future<void> updateTodo(Todo todo) async => await db.updateTodo(todo);
  Future<void> deleteTodo(int id) async => await db.deleteTodo(id);
}
