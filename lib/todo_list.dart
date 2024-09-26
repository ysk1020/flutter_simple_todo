import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/todo_item.dart';
import 'package:todo/todo_provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});

  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // prevent dissmissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Todo'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter todo item'),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newTodo = _textFieldController.text;
                Provider.of<TodoProvider>(context, listen: false)
                    .addTodoItem(newTodo);
                _textFieldController.clear();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: List.generate(
          todoProvider.todos.length,
          (index) {
            final todo = todoProvider.todos[index];
            return TodoItem(
              todo: todo,
              onTodoChagned: () {
                todoProvider.todoChange(index);
              },
              onDelete: () {
                todoProvider.todoDelete(index);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog();
        },
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
