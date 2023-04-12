import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shortid/shortid.dart';
import 'package:skartner_app/domain/model/todo.dart';
import 'package:skartner_app/presentation/viewmodel/module.dart';
import 'package:skartner_app/presentation/widgets/extensions.dart';

class TodosEdit extends ConsumerStatefulWidget {
  const TodosEdit({super.key, this.todoId});
  final String? todoId;

  @override
  ConsumerState<TodosEdit> createState() => _TodosEditState();
}

class _TodosEditState extends ConsumerState<TodosEdit> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  bool isCompleted = false;
  late final model = ref.read(todosListModel);
  bool edited = false;
  void onInputEdited() {
    if (mounted) {
      setState(() {
        edited = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title.addListener(onInputEdited);
    description.addListener(onInputEdited);
    if (widget.todoId != null) {
      model.getTodo(widget.todoId!).then((todo) {
        if (todo != null) {
          title.text = todo.title;
          description.text = todo.description ?? '';
          if (mounted) {
            setState(() {
              isCompleted = todo.completed;
              edited = false;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.todoId == null
            ? const Text('Add Todo')
            : const Text('Edit Todo'),
        actions: [
          // Delete todo
          if (widget.todoId != null)
            IconButton(
              onPressed: () async {
                final router = GoRouter.of(context);
                final messenger = ScaffoldMessenger.of(context);
                final confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete todo?'),
                    content: const Text(
                        'Are you sure you want to delete this todo?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  await model.deleteTodo(widget.todoId!);
                  messenger.toast('Deleted Successfully!');
                  if (router.canPop()) {
                    router.pop();
                  }
                }
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            onWillPop: () async {
              if (edited) {
                final confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Discard changes?'),
                    content: const Text(
                        'Are you sure you want to discard your changes?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  return true;
                }
                return false;
              }
              return true;
            },
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                CheckboxListTile(
                  title: const Text('Completed'),
                  value: isCompleted,
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        isCompleted = value!;
                      });
                      onInputEdited();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            final todo = Todo(
              id: widget.todoId ?? shortid.generate(),
              title: title.text,
              description: description.text,
              completed: isCompleted,
            );

            final messenger = ScaffoldMessenger.of(context);
            final router = GoRouter.of(context);
            await model.saveTodo(todo);
            messenger.toast('Todo saved!');
            if (router.canPop()) {
              router.pop();
            }
          }
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
