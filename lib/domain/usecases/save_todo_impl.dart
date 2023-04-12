import 'package:skartner_app/data/repository/todos.dart';
import 'package:skartner_app/domain/model/todo.dart';
import 'package:skartner_app/domain/usecases/save_todo.dart';

class SaveTodoUseCaseImpl extends SaveTodoUseCase {
  final TodosRepository todosRepository;

  SaveTodoUseCaseImpl(this.todosRepository);
  @override
  Future<void> execute(Todo todo) async {
    await todosRepository.saveTodo(todo);
  }
}
