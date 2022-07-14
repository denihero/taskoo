import 'package:flutter/material.dart';
import 'package:taskoo/service/database/sql_crud.dart';

class TaskAddSheet extends StatefulWidget {

  const TaskAddSheet({Key? key, required this.focusNode, required this.updateState}) : super(key: key);
  final FocusNode focusNode;
  final Function() updateState;

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
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: true,
                controller: textController,
                focusNode: widget.focusNode,
                cursorColor: Colors.teal,
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
                controller: descriptionController,
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
                  offset: const Offset(-10, 0),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.teal,
                    child: IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if(textController.text.isEmpty || textController.text.isEmpty && descriptionController.text.isEmpty){
                            return;
                          }else{
                            DatabaseCRUD.insertTask(textController.text, descriptionController.text);
                            Navigator.pop(context);
                            widget.updateState;
                          }
                        },
                        icon: const Icon(
                          Icons.send_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
