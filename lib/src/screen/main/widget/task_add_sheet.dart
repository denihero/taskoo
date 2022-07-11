import 'package:flutter/material.dart';

class TaskAddSheet extends StatefulWidget {

  const TaskAddSheet({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  State<TaskAddSheet> createState() => _TaskAddSheetState();
}

class _TaskAddSheetState extends State<TaskAddSheet> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[800]!,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: true,
                focusNode: widget.focusNode,
                decoration: const InputDecoration(
                    hintText: 'Напр,. пойти в ресторан',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Описание',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(right: 10),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.send_outlined)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
