import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:skartner_app/data/repository/todos.dart';
import 'package:skartner_app/data/source/files.dart';
import 'package:skartner_app/domain/model/todo.dart';
import 'package:skartner_app/domain/model/todos.dart';

class TodosRepositoryImpl extends TodosRepository {
  TodosRepositoryImpl(this.files);
  final Files files;

  late final String path = "todos.json";

  @override
  Future<void> deleteAllTodo() async {
    await files.delete(path);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await loadTodos();
    final newTodos = todos.values.where((todo) => todo.id != id).toList();
    await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final todos = await loadTodos();
    final todo = todos.values.firstWhereOrNull((todo) => todo.id == id);
    return todo;
  }

  @override
  Future<Todos> loadTodos() async {
    final content = await files.read(path);
    if (content == null) return const Todos(values: []);
    final todos = Todos.fromJson(jsonDecode(content));
    return todos;
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = await loadTodos();
    final newTodos = todos.values.where((t) => t.id != todo.id).toList();
    newTodos.add(todo);
    await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
  }
}
