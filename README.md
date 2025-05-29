# TaskMaster - Flutter Todo App

A modern, feature-rich todo application built with Flutter using the BLoC pattern for state management. TaskMaster helps you organize your life, one task at a time.

## 📱 App Description

TaskMaster is a comprehensive todo application that allows users to manage their daily tasks efficiently. The app features a clean, intuitive interface with both light and dark theme support. Users can create, edit, delete, and organize their tasks with due dates and detailed descriptions.

### Key Features

- ✅ **Task Management**: Create, edit, delete, and toggle task completion
- 📅 **Due Dates**: Set and track due dates for tasks with overdue indicators
- 🔍 **Smart Filtering**: Filter tasks by All, Completed, or Pending status
- 🌙 **Theme Toggle**: Switch between light and dark themes
- 💾 **Persistent Storage**: SQLite database for reliable data persistence
- 🎨 **Modern UI**: Beautiful splash screen with animations and intuitive design
- ⚡ **State Management**: Robust BLoC pattern implementation

## Screen-Recording and Screen-Shots



https://github.com/user-attachments/assets/a6b81448-2848-4e98-b71a-3683bd8ed93e



![Light_mode](https://github.com/user-attachments/assets/b4dca8ec-19ef-40cc-9452-5f81fc979d37)
![Dark_mode](https://github.com/user-attachments/assets/8bff37ad-f991-49a2-94e7-d2a270c2dfce)



## 🚀 How to Run

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/manik0706/taskmaster_todo_app.git
   cd taskmaster-flutter-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Alternative Run Commands

- **Debug mode**: `flutter run --debug`
- **Release mode**: `flutter run --release`
- **Specific device**: `flutter run -d <device-id>`

## 🏗️ Project Structure

```
lib/
├── bloc/                 # BLoC pattern implementation
│   ├── todo_bloc.dart
│   ├── todo_event.dart
│   └── todo_state.dart
├── data/                 # Data layer
│   ├── todo_database.dart
│   └── todo_repository.dart
├── models/              # Data models
│   └── todo.dart
├── screens/             # UI screens
│   ├── home_screen.dart
│   └── splash_screen.dart
├── theme/               # Theme management
│   └── theme_cubit.dart
├── widgets/             # Reusable widgets
│   └── todo_tile.dart
└── main.dart           # App entry point
```

## 🎯 What I Implemented from the Optional Section

### ✅ Implemented Features

1. **✅ Due Dates to Tasks**
    - Added `dueDate` field to Todo model
    - Date picker integration for selecting due dates
    - Visual indicators for overdue tasks
    - Formatted date display

2. **✅ SQLite via sqflite**
    - Complete SQLite implementation replacing shared_preferences
    - Database versioning and migration support
    - CRUD operations for todos
    - Persistent data storage

3. **✅ Theme Toggle (Light/Dark)**
    - Implemented ThemeCubit for theme management
    - Light and dark theme support
    - Theme toggle button in app bar
    - Consistent theming across all components

### 🔄 Additional Features Beyond Requirements

- **Splash Screen**: Beautiful animated splash screen with custom logo
- **Task Filtering**: Filter tasks by status (All, Completed, Pending)
- **Swipe to Delete**: Intuitive swipe gesture for task deletion
- **Confirmation Dialogs**: Prevent accidental deletions
- **Overdue Task Highlighting**: Visual indicators for overdue tasks
- **Empty State UI**: Friendly empty state with helpful messages
- **Responsive Design**: Optimized for different screen sizes

### ⏳ Not Implemented

- **Unit Tests**: Due to time constraints, comprehensive unit tests for BLoC and repository are not included
- **Hydrated BLoC**: Using SQLite for persistence instead of hydrated_bloc

## 🛠️ Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **flutter_bloc**: State management
- **sqflite**: SQLite database
- **Material Design**: UI components

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.1      # State management
  sqflite: ^2.4.1           # SQLite database
  shared_preferences: ^2.5.3 # Local preferences
  uuid: ^4.5.1              # Unique ID generation
  intl: ^0.20.2             # Internationalization
  cupertino_icons: ^1.0.8   # iOS style icons
```

## 🎨 Features Showcase

### Core Functionality
- **Task Creation**: Add tasks with title, description, and due date
- **Task Editing**: Modify existing tasks inline
- **Task Completion**: Toggle task status with visual feedback
- **Task Deletion**: Swipe-to-delete with confirmation

### Advanced Features
- **Due Date Management**: Set, edit, and clear due dates
- **Overdue Detection**: Automatic highlighting of overdue tasks
- **Theme Switching**: Seamless light/dark mode toggle
- **Data Persistence**: Reliable SQLite storage

### User Experience
- **Animated Splash**: Professional app loading experience
- **Empty States**: Helpful guidance when no tasks exist
- **Confirmation Dialogs**: Prevent accidental data loss
- **Responsive Design**: Works across different screen sizes

## 🔧 Architecture

The app follows clean architecture principles with clear separation of concerns:

- **Presentation Layer**: Screens and widgets
- **Business Logic Layer**: BLoC pattern for state management
- **Data Layer**: Repository pattern with SQLite database

---

**TaskMaster** - *Organize your life, one task at a time* 📝✨
