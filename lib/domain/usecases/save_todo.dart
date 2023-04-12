import 'package:skartner_app/domain/model/todo.dart';

abstract class SaveTodoUseCase {
  Future<void> execute(Todo todo);
}
