import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skartner_app/presentation/viewmodel/module.dart';
import 'package:skartner_app/presentation/widgets/todo_tile.dart';

class TodosList extends ConsumerWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosListState);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todos'),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/todos/add');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: todos.values.isEmpty
          ? const Center(
              child: Text('No Todos found'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.active.length,
                    itemBuilder: (context, index) {
                      final todo = todos.active[index];
                      return TodoTile(todo: todo);
                    },
                  ),
                ),
                if (todos.completed.isNotEmpty)
                  ExpansionTile(
                    title: const Text('Completed'),
                    initiallyExpanded: todos.completed.isNotEmpty,
                    children: [
                      for (final todo in todos.completed) TodoTile(todo: todo)
                    ],
                  ),
              ],
            ),
    );
  }
}
