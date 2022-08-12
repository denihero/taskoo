import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/src/screen/bloc/crud_task/task_crud_bloc.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key, required this.backgroundColor, required this.textController, required this.subtitleController}) : super(key: key);

  final Color backgroundColor;
  final TextEditingController textController;
  final TextEditingController subtitleController;


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 17,
      backgroundColor: backgroundColor,
      child: IconButton(
          icon: const Icon(
            Icons.send_outlined,
            color: Colors.white,
            size: 23,
          ),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: () async {
            if (textController.text.isEmpty ||
                textController.text.isEmpty &&
                    subtitleController.text.isEmpty) {
              return;
            } else {
              context.read<TaskCrudBloc>().add(
                  TaskAddEvent(
                      title: textController.text,
                      subtitle: subtitleController.text));
              textController.text = '';
              subtitleController.text = '';
            }
          }),
    );
  }
}
