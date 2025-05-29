import '../models/todo.dart';
import 'todo_event.dart';

class TodoState {
  final List<Todo> todos;
  final Filter activeFilter;
  final Todo? lastDeleted;

  TodoState({
    required this.todos,
    this.activeFilter = Filter.all,
    this.lastDeleted,
  });

  List<Todo> get filteredTodos {
    switch (activeFilter) {
      case Filter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case Filter.pending:
        return todos.where((todo) => !todo.isCompleted).toList();
      case Filter.all:
      default:
        return todos;
    }
  }

  TodoState copyWith({
    List<Todo>? todos,
    Filter? activeFilter,
    Todo? lastDeleted,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      activeFilter: activeFilter ?? this.activeFilter,
      lastDeleted: lastDeleted,
    );
  }
}
