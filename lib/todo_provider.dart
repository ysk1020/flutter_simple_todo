import "package:flutter/material.dart";
import 'package:todo/models/todo.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  final TextEditingController _textFieldController = TextEditingController();
  List<Todo> get todos => _todos;

  void addTodoItem(String name) {
    _todos.add(Todo(name: name, isCompleted: false));
    _textFieldController.clear();
    notifyListeners();
  }

  void todoChange(int index) {
    todos[index].isCompleted = !todos[index].isCompleted;
    notifyListeners();
  }

  void todoDelete(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
