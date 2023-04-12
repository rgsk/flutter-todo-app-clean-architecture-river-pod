// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skartner_app/domain/model/todo.dart';
import 'package:skartner_app/domain/model/todos.dart';
import 'package:skartner_app/domain/usecases/module.dart';
import 'package:state_notifier/state_notifier.dart';

class TodosStateNotifier extends StateNotifier<Todos> {
  TodosStateNotifier(this.ref) : super(const Todos(values: [])) {
    refreshTodos();
  }

  final Ref ref;
  late final getTodos = ref.read(getTodosProvider);

  Future<void> refreshTodos() async {
    state = await getTodos.execute();
  }

  Future<void> saveTodo(Todo todo) async {
    await ref.read(saveTodoProvider).execute(todo);
    await refreshTodos();
  }

  Future<Todo?> getTodo(String id) async {
    return await ref.read(getTodoProvider).execute(id);
  }

  Future<void> deleteTodo(String id) async {
    await ref.read(deleteTodoProvider).execute(id);
    await refreshTodos();
  }
}

final todosListState = StateNotifierProvider<TodosStateNotifier, Todos>(
  (ref) => TodosStateNotifier(ref),
);

final todosListModel = Provider<TodosStateNotifier>((ref) {
  return ref.watch(todosListState.notifier);
});
