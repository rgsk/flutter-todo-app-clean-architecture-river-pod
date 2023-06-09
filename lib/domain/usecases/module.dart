import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skartner_app/data/repository/module.dart';
import 'package:skartner_app/domain/usecases/delete_todo.dart';
import 'package:skartner_app/domain/usecases/delete_todo_impl.dart';
import 'package:skartner_app/domain/usecases/get_todo.dart';
import 'package:skartner_app/domain/usecases/get_todo_impl.dart';
import 'package:skartner_app/domain/usecases/get_todos.dart';
import 'package:skartner_app/domain/usecases/get_todos_impl.dart';
import 'package:skartner_app/domain/usecases/save_todo.dart';
import 'package:skartner_app/domain/usecases/save_todo_impl.dart';

final getTodosProvider = Provider<GetTodosUseCase>((ref) {
  return GetTodosUseCaseImpl(ref.read(todosProvider));
});

final getTodoProvider = Provider<GetTodoUseCase>((ref) {
  return GetTodoUseCaseImpl(ref.read(todosProvider));
});

final saveTodoProvider = Provider<SaveTodoUseCase>((ref) {
  return SaveTodoUseCaseImpl(ref.read(todosProvider));
});

final deleteTodoProvider = Provider<DeleteTodoUseCase>((ref) {
  return DeleteTodoUseCaseImpl(ref.read(todosProvider));
});
