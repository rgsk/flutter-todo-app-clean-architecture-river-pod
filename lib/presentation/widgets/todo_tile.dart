import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:skartner_app/domain/model/todo.dart";
import "package:skartner_app/presentation/viewmodel/module.dart";

class TodoTile extends ConsumerWidget {
  const TodoTile({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(todo.title),
      subtitle: todo.description != null ? Text(todo.description!) : null,
      onTap: () {
        context.go('/todos/${todo.id}');
      },
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          if (value != null) {
            ref.read(todosListModel).saveTodo(
                  todo.copyWith(
                    completed: value,
                  ),
                );
          }
        },
      ),
    );
  }
}
