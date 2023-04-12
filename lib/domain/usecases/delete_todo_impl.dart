import 'package:skartner_app/data/repository/todos.dart';
import 'package:skartner_app/domain/usecases/delete_todo.dart';

class DeleteTodoUseCaseImpl extends DeleteTodoUseCase {
  final TodosRepository todosRepository;

  DeleteTodoUseCaseImpl(this.todosRepository);
  @override
  Future<void> execute(String id) async {
    await todosRepository.deleteTodo(id);
  }
}
