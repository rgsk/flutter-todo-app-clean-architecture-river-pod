import 'package:skartner_app/data/repository/todos.dart';
import 'package:skartner_app/domain/model/todo.dart';
import 'package:skartner_app/domain/usecases/get_todo.dart';

class GetTodoUseCaseImpl extends GetTodoUseCase {
  final TodosRepository todosRepository;

  GetTodoUseCaseImpl(this.todosRepository);
  @override
  Future<Todo?> execute(String id) async {
    return todosRepository.getTodoById(id);
  }
}
