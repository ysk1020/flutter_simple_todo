import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChagned,
    required this.onDelete,
  });

  final Todo todo;
  final void Function(Todo todo) onTodoChagned;
  final void Function(Todo todo) onDelete;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;
    return const TextStyle(
      color: Colors.black,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChagned(todo); //tapping the item
      },
      leading: Checkbox(
        checkColor: const Color.fromARGB(255, 101, 0, 126),
        activeColor: const Color.fromARGB(255, 255, 255, 255),
        value: todo.isCompleted,
        onChanged: (value) {
          onTodoChagned(todo); //tapping the checkbox
        },
      ), //chekbox
      title: Row(
        children: [
          Expanded(
            child: Text(
              todo.name,
              style: _getTextStyle(todo.isCompleted),
            ),
          ),
          IconButton(
            onPressed: () {
              onDelete(todo);
            },
            icon: const Icon(
              Icons.delete_forever_outlined,
            ),
            iconSize: 30,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
