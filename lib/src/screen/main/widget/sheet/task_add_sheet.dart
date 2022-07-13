import 'package:flutter/material.dart';
import 'package:taskoo/service/database/sql_crud.dart';

class TaskAddSheet extends StatefulWidget {

  const TaskAddSheet({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  State<TaskAddSheet> createState() => _TaskAddSheetState();
}

class _TaskAddSheetState extends State<TaskAddSheet> {

  final textController = TextEditingController();
  final descriptionController = TextEditingController();

  final DatabaseCRUD databaseCRUD = DatabaseCRUD();

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
                controller: textController,
                focusNode: widget.focusNode,
                decoration: const InputDecoration(
                    hintText: 'Напр,. пойти в ресторан',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero),
              ),
              TextFormField(
                controller: descriptionController,
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
                    onPressed: ()  async{
                      await databaseCRUD.insertTask(textController.text, descriptionController.text);
                      //Navigator.pop(context);
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
