import '../models/todo.dart';

abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;
  AddTodo(this.todo);
}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final Todo todo;
  DeleteTodo(this.todo);
}

class UndoDelete extends TodoEvent {}

class ToggleTodo extends TodoEvent {
  final Todo todo;
  ToggleTodo(this.todo);
}

enum Filter { all, completed, pending }

class FilterTodos extends TodoEvent {
  final Filter filter;
  FilterTodos(this.filter);
}
