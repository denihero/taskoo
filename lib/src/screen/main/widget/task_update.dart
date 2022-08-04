import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/src/screen/bloc/crud_task/task_crud_bloc.dart';

class TaskUpdateSheet extends StatelessWidget {
  TaskUpdateSheet(
      {Key? key, required this.title, required this.subtitle, required this.id})
      : super(key: key);
  late final String title;
  final String subtitle;
  final int id;

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = title;
    subtitleController.text = subtitle;
    titleController.selection = TextSelection.fromPosition(
        TextPosition(offset: titleController.text.length));
    subtitleController.selection = TextSelection.fromPosition(
        TextPosition(offset: subtitleController.text.length));
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[800]!,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              isScrollingIcon(),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: true,
                cursorColor: Colors.teal,
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: 'Напр,. пойти в ресторан',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero),
              ),
              TextFormField(
                cursorHeight: 17,
                cursorColor: Colors.teal,
                controller: subtitleController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: 'Описание',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Transform.translate(
                    offset: const Offset(-10, -10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      onPressed: () async {
                        context.read<TaskCrudBloc>().add(TaskUpdateEvent(
                            title: titleController.text,
                            subtitle: subtitleController.text,
                            id: id));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Update'),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget isScrollingIcon() {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(20)),
    );
  }
}
