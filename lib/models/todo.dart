class Todo {
  final int? id;
  final String title;
  final String details;
  final bool isCompleted;
  final DateTime? dueDate; // Added date field

  Todo({
    this.id,
    required this.title,
    required this.details,
    this.isCompleted = false,
    this.dueDate, // Added date parameter
  });

  Todo copyWith({
    int? id,
    String? title,
    String? details,
    bool? isCompleted,
    DateTime? dueDate, // Added date parameter
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate, // Added date assignment
    );
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      isCompleted: map['isCompleted'] == 1,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null, // Added date parsing
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'isCompleted': isCompleted ? 1 : 0,
      'dueDate': dueDate?.toIso8601String(), // Added date serialization
    };
  }

  // Helper method to format date for display
  String get formattedDate {
    if (dueDate == null) return '';
    return '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}';
  }

  // Helper method to check if task is overdue
  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }
}