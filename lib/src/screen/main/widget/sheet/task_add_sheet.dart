import 'package:flutter/material.dart';
import 'package:taskoo/service/database/sql_crud.dart';
import 'package:taskoo/src/screen/main/widget/button/send.dart';

class TaskAddSheet extends StatefulWidget {
  const TaskAddSheet({Key? key}) : super(key: key);

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
      sendIconColor =
          textController.text.isEmpty ? Colors.transparent : Colors.teal;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Hero(
        tag: 'key',
        child: Container(
          height: 500,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(29,29,29,1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
            child: ValueListenableBuilder(
              valueListenable: addTaskFocusNode,
              builder:
                  (BuildContext context, FocusNode focusNode, Widget? child) {
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
                      onChanged: (str){
                        if(str == '!!'){
                           // showMenu(
                           //     context: context,
                           //     position: RelativeRect.fromSize(
                           //       Rect.fromCenter(
                           //           center: Offset.zero, width: 100, height: 100),
                           //       Size(100, 100),
                           //     ),
                           //     items: [
                           //      const PopupMenuItem(child: Text('12')),
                           //      PopupMenuItem(child: Text('12')),
                           //      PopupMenuItem(child: Text('12')),
                           //     ]
                           // );
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'Напр,. пойти в ресторан с подругой',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 17,color: Colors.grey),
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
                    Transform.translate(
                      offset: const Offset(0, 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 24,
                            constraints: const BoxConstraints(minHeight: 1),
                            padding: EdgeInsets.zero,
                            onPressed: () {

                            },
                            icon: const Icon(Icons.flag_outlined),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            iconSize: 24,
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(Icons.timer_sharp),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Transform.translate(
                        offset: const Offset(-5,15),
                        child: SendButton(
                          backgroundColor: sendIconColor,
                          textController: textController,
                          subtitleController: subtitleController,
                        )
                      ),
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
   windowsw(){
    return PopupMenuButton(
        itemBuilder:(context){
          return [
            const PopupMenuItem(child: Text('1')),
            const PopupMenuItem(child: Text('2')),
            const PopupMenuItem(child: Text('3')),
            const PopupMenuItem(child: Text('4')),
          ];
        }
    );
  }
}
