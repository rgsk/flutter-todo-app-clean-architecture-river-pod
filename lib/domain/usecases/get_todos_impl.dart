import 'package:skartner_app/domain/model/todos.dart';
import 'package:skartner_app/data/repository/todos.dart';
import 'package:skartner_app/domain/usecases/get_todos.dart';

class GetTodosUseCaseImpl extends GetTodosUseCase {
  final TodosRepository todosRepository;

  GetTodosUseCaseImpl(this.todosRepository);

  @override
  Future<Todos> execute() => todosRepository.loadTodos();
}
