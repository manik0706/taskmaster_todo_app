import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/todo_repository.dart';
import '../models/todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodoState(todos: [])) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UndoDelete>(_onUndoDelete);
    on<ToggleTodo>(_onToggleTodo);
    on<FilterTodos>(_onFilterTodos);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    final todos = await repository.loadTodos();
    emit(state.copyWith(todos: todos));
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    await repository.addTodo(event.todo);
    add(LoadTodos());
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    await repository.updateTodo(event.todo);
    add(LoadTodos());
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    await repository.deleteTodo(event.todo.id!);
    emit(state.copyWith(lastDeleted: event.todo));
    add(LoadTodos());
  }

  Future<void> _onUndoDelete(UndoDelete event, Emitter<TodoState> emit) async {
    if (state.lastDeleted != null) {
      await repository.addTodo(state.lastDeleted!);
      emit(state.copyWith(lastDeleted: null));
      add(LoadTodos());
    }
  }

  Future<void> _onToggleTodo(ToggleTodo event, Emitter<TodoState> emit) async {
    final updated = event.todo.copyWith(isCompleted: !event.todo.isCompleted);
    add(UpdateTodo(updated));
  }

  void _onFilterTodos(FilterTodos event, Emitter<TodoState> emit) {
    emit(state.copyWith(activeFilter: event.filter));
  }
}
