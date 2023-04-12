import 'package:skartner_app/domain/model/todos.dart';

abstract class GetTodosUseCase {
  Future<Todos> execute();
}
