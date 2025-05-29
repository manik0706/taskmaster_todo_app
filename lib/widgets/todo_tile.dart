import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({required this.todo});

  Future<void> _selectDate(BuildContext context, TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todo.dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365 * 2)),
    );
    if (picked != null) {
      dateController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void _showEditDialog(BuildContext context) {
    final titleController = TextEditingController(text: todo.title);
    final detailsController = TextEditingController(text: todo.details);
    final dateController = TextEditingController(text: todo.formattedDate);
    DateTime? selectedDate = todo.dueDate;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Task'),
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
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(), // Only allow current date and future dates
                  lastDate: DateTime.now().add(Duration(days: 365 * 2)),
                );
                if (picked != null) {
                  selectedDate = picked;
                  dateController.text = '${picked.day}/${picked.month}/${picked.year}';
                }
              },
            ),
            SizedBox(height: 8),
            if (dateController.text.isNotEmpty)
              TextButton(
                onPressed: () {
                  selectedDate = null;
                  dateController.clear();
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
              final updated = todo.copyWith(
                title: titleController.text,
                details: detailsController.text,
                dueDate: selectedDate,
              );
              context.read<TodoBloc>().add(UpdateTodo(updated));
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    context.read<TodoBloc>().add(DeleteTodo(todo));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted'),
        // action: SnackBarAction(
        //   label: 'Undo',
        //   onPressed: () => context.read<TodoBloc>().add(UndoDelete()),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 28,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => _handleDelete(context),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          onTap: () => _showEditDialog(context),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              color: todo.isOverdue && !todo.isCompleted ? Colors.red : null,
              fontWeight: todo.isOverdue && !todo.isCompleted ? FontWeight.bold : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo.details.isNotEmpty) ...[
                Text(todo.details),
                SizedBox(height: 4),
              ],
              if (todo.dueDate != null) ...[
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: todo.isOverdue && !todo.isCompleted
                          ? Colors.red
                          : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    SizedBox(width: 4),
                    Text(
                      todo.formattedDate,
                      style: TextStyle(
                        color: todo.isOverdue && !todo.isCompleted
                            ? Colors.red
                            : Theme.of(context).textTheme.bodySmall?.color,
                        fontWeight: todo.isOverdue && !todo.isCompleted
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                    if (todo.isOverdue && !todo.isCompleted) ...[
                      SizedBox(width: 8),
                      Text(
                        'OVERDUE',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => context.read<TodoBloc>().add(ToggleTodo(todo)),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _handleDelete(context),
          ),
        ),
      ),
    );
  }
}