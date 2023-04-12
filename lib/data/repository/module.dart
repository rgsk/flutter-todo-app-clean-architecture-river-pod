import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skartner_app/data/repository/todos.dart';
import 'package:skartner_app/data/repository/todos_impl.dart';
import 'package:skartner_app/data/source/module.dart';

final todosProvider = Provider<TodosRepository>((ref) {
  return TodosRepositoryImpl(ref.read(filesProvider));
});
