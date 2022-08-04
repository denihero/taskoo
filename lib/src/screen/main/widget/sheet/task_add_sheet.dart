import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';
import 'package:taskoo/src/screen/bloc/crud_task/task_crud_bloc.dart';

class TaskAddSheet extends StatefulWidget {
  const   TaskAddSheet(
      {Key? key})
      : super(key: key);

  @override
  State<TaskAddSheet> createState() => _TaskAddSheetState();
}

class _TaskAddSheetState extends State<TaskAddSheet> {
  final ValueNotifier<FocusNode> addTaskFocusNode = ValueNotifier(FocusNode());
  final textController = TextEditingController();
  final subtitleController = TextEditingController();


  final DatabaseCRUD databaseCRUD = DatabaseCRUD();
  Color sendIconColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      sendIconColor = textController.text.isEmpty ? Colors.transparent:Colors.teal;
      setState((){

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Hero(
        tag: 'key',
        child: Container(
          height: 471,
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
            child: ValueListenableBuilder(
              valueListenable: addTaskFocusNode,
              builder: (BuildContext context,FocusNode focusNode, Widget? child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autofocus: true,
                      autocorrect: true,
                      controller: textController,
                      focusNode: focusNode,
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
                          offset: const Offset(-10, 0),
                          child: CircleAvatar(
                            radius: 19,
                            backgroundColor: sendIconColor,
                            child: IconButton(
                                icon: const Icon(Icons.send_outlined,color: Colors.white,),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () async{
                                  if(textController.text.isEmpty || textController.text.isEmpty && subtitleController.text.isEmpty){
                                    return;
                                  }else{
                                   context.read<TaskCrudBloc>().add(TaskAddEvent(title: textController.text, subtitle: subtitleController.text));
                                    textController.text = '';
                                    subtitleController.text = '';
                                  }
                                }

                            ),
                          )),
                    )
                  ],
                );
              },

            ),
          ),
        ),
      ),
    );
  }
}
