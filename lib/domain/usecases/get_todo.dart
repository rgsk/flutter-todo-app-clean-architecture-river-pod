import 'package:skartner_app/domain/model/todo.dart';

abstract class GetTodoUseCase {
  Future<Todo?> execute(String id);
}
