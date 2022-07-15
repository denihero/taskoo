import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';
import 'package:taskoo/src/screen/bloc/add_task/add_task_cubit.dart';
import 'package:taskoo/src/screen/bloc/get_task/get_task_cubit.dart';

class TaskAddSheet extends StatefulWidget {
  const TaskAddSheet(
      {Key? key,required this.updateState})
      : super(key: key);
  final Function() updateState;

  @override
  State<TaskAddSheet> createState() => _TaskAddSheetState();
}

class _TaskAddSheetState extends State<TaskAddSheet> {
  final ValueNotifier<FocusNode> addTaskFocusNode = ValueNotifier(FocusNode());
  final textController = TextEditingController();
  final descriptionController = TextEditingController();


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
    return WillPopScope(
      onWillPop: () async {
        if(addTaskFocusNode.value.hasFocus){
          addTaskFocusNode.value.unfocus();
          Navigator.pop(context);
        }


      return Future.value(addTaskFocusNode.value.hasFocus);

      },
      child: SingleChildScrollView(
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
                            backgroundColor: sendIconColor,
                            child: IconButton(
                                icon: const Icon(Icons.send_outlined,color: Colors.white,),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () async{
                                  if(textController.text.isEmpty || textController.text.isEmpty && descriptionController.text.isEmpty){
                                    return;
                                  }else{
                                    BlocProvider.of<AddTaskCubit>(context).addTask(textController.text, descriptionController.text);
                                    BlocProvider.of<GetTaskCubit>(context).getTasks();
                                    textController.text = '';
                                    descriptionController.text = '';
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
