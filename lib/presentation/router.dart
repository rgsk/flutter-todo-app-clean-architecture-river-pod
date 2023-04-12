import 'package:go_router/go_router.dart';
import 'package:skartner_app/presentation/screens/todos_edit.dart';
import 'package:skartner_app/presentation/screens/todos_list.dart';

final router = GoRouter(
  initialLocation: '/todos',
  routes: [
    GoRoute(
      path: '/todos',
      builder: (context, state) => const TodosList(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const TodosEdit(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) => TodosEdit(
            todoId: state.params['id'],
          ),
        ),
      ],
    ),
  ],
);
