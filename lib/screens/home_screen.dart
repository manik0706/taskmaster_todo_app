import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_demo/theme/theme_cubit.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/todo_tile.dart';
import '../models/todo.dart';

class HomeScreen extends StatelessWidget {
  void _showAddDialog(BuildContext context) {
    final titleController = TextEditingController();
    final detailsController = TextEditingController();
    final dateController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(labelText: 'Details'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365 * 2)),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      dateController.text =
                          '${picked.day}/${picked.month}/${picked.year}';
                    });
                  }
                },
              ),
              SizedBox(height: 8),
              if (dateController.text.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = null;
                      dateController.clear();
                    });
                  },
                  child: Text('Clear Date'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  final todo = Todo(
                    title: titleController.text,
                    details: detailsController.text,
                    dueDate: selectedDate,
                  );
                  context.read<TodoBloc>().add(AddTodo(todo));
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Tasks',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          // Theme toggle button
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(themeState.themeIcon),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                tooltip: themeState.currentTheme == AppTheme.light
                    ? 'Switch to Dark Mode'
                    : 'Switch to Light Mode',
              );
            },
          ),
          // Filter menu
          PopupMenuButton(
            onSelected: (value) =>
                context.read<TodoBloc>().add(FilterTodos(value)),
            itemBuilder: (_) => [
              PopupMenuItem(value: Filter.all, child: Text("All")),
              PopupMenuItem(value: Filter.completed, child: Text("Completed")),
              PopupMenuItem(value: Filter.pending, child: Text("Pending")),
            ],
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.filteredTodos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No tasks yet!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap + to add your first task',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.filteredTodos.length,
            itemBuilder: (context, index) {
              return TodoTile(todo: state.filteredTodos[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),

        child: Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}
