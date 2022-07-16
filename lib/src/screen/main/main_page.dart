import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/service/database/sql_crud.dart';
import 'package:taskoo/src/screen/bloc/add_task/add_task_cubit.dart';
import 'package:taskoo/src/screen/main/widget/sheet/menu_bottom_sheet.dart';
import 'package:taskoo/src/screen/main/widget/sheet/task_add_sheet.dart';
import 'package:taskoo/src/screen/main/widget/task_card.dart';

import '../bloc/get_task/get_task_cubit.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  late final AnimationController? animationController;


  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetTaskCubit>(context).getTasks();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),

    );
  }

  @override
  void dispose() {

    super.dispose();
  }

  final choice = [
    PopupMenuItem(
      value: 1,
      // row with 2 children
      child: Row(
        children: const [
          Icon(Icons.add_chart),
          SizedBox(
            width: 10,
          ),
          Text("Отображение")
        ],
      ),
    ),
    PopupMenuItem(
      value: 2,
      // row with two children
      child: Row(
        children: const [
          Icon(Icons.book),
          SizedBox(
            width: 10,
          ),
          Text("Журнал действий")
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Taskoo'),
            actions: [
              PopupMenuButton<int>(
                itemBuilder: (context) => choice,
                elevation: 2,
                // on selected we show the dialog box
                onSelected: (value) {},
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await BlocProvider.of<GetTaskCubit>(context).getTasks();
            },
            child: BlocConsumer<GetTaskCubit, GetTaskState>(
              builder: (context, state) {
                if(state is GetTaskLoading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(state is GetTaskError){
                  return const Text('Some thing get wrong');
                }else if(state is GetTaskSuccess){
                  final task = state.task;
                  return ListView.builder(
                      itemCount: task.length,
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          title: task[index]['title'],
                          subtitle: task[index]['subtitle'],
                          id: task[index]['id'],
                          onDelete: (value) {
                            BlocProvider.of<AddTaskCubit>(context).deleteTask(task[index]['id']);
                          },
                          keyValue: task[index]['id'],
                        );
                      }
                  );
                }
                return const SizedBox();

              },
              listener: (context,state){
                if(state is AddTaskSuccess){
                  BlocProvider.of<GetTaskCubit>(context).getTasks();
                }
              }
            ),
          ),
          bottomNavigationBar: Container(
            height: 55,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: BottomAppBar(
              notchMargin: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const MenuBottomSheet();
                            });
                      },
                      icon: const Icon(
                        Icons.menu,
                        size: 28,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<GetTaskCubit>(context).getTasks();
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            size: 28,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  barrierColor: Colors.black38,
                  isScrollControlled:true,
                  context: context,
                  transitionAnimationController: animationController,
                  builder: (context) {
                    return TaskAddSheet(

                        updateState: () => BlocProvider.of<GetTaskCubit>(context).getTasks()

                    );
                  });
            },
            isExtended: true,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
  _onBackPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
