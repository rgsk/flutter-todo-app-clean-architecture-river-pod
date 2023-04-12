import 'package:skartner_app/domain/model/todo.dart';
import 'package:skartner_app/domain/model/todos.dart';

abstract class TodosRepository {
  Future<Todos> loadTodos();
  Future<void> saveTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<Todo?> getTodoById(String id);
  Future<void> deleteAllTodo();
}
