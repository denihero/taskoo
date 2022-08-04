import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:taskoo/src/screen/main/widget/task_update.dart';

import '../../bloc/crud_task/task_crud_bloc.dart';

class TaskCardWidget extends StatelessWidget {
  TaskCardWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.keyValue,
      required this.onDelete,
      required this.id})
      : super(key: key);
  final String title;
  final String subtitle;
  final int id;
  final int keyValue;
  final Function(DismissDirection) onDelete;

  final ValueNotifier<bool> isChecked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Dismissible(
        key: Key('$keyValue'),
        onDismissed: onDelete,
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(Icons.cancel),
        ),
        child: ListTile(
          onTap: () {
            Timer(const Duration(milliseconds: 150), () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  barrierColor: Colors.black38,
                  context: context,
                  builder: (context) {
                    return TaskUpdateSheet(
                      title: title,
                      subtitle: subtitle,
                      id: id,
                    );
                  });
            });
          },
          visualDensity: VisualDensity.adaptivePlatformDensity,
          leading: Transform.translate(
            offset: const Offset(0, -13),
            child: RoundCheckBox(
              size: 23,
              checkedColor: Colors.teal,
              borderColor: Colors.white,
              animationDuration: const Duration(milliseconds: 100),
              onTap: (selected) {
                if (selected == true) {
                  context.read<TaskCrudBloc>().add(TaskDeleteEvent(id: id));
                }
              },
              isChecked: isChecked.value,
            ),
          ),
          title: Transform.translate(
              offset: const Offset(-20, 0), child: Text(title)),
          subtitle: Transform.translate(
            offset: const Offset(-20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.translate(
                    offset: const Offset(50, 5),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: const [
                          Text(
                            'Входящие',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          Icon(
                            Icons.inbox,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
