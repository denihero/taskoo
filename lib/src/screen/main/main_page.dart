import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/src/screen/bloc/crud_task/task_crud_bloc.dart';
import 'package:taskoo/src/screen/main/widget/sheet/menu_bottom_sheet.dart';
import 'package:taskoo/src/screen/main/widget/sheet/search_sheet.dart';
import 'package:taskoo/src/screen/main/widget/sheet/task_add_sheet.dart';
import 'package:taskoo/src/screen/main/widget/task_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200));
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<TaskCrudBloc>(context).add(TaskGetEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed(context),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(29,29,29,1),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Taskoo'),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<TaskCrudBloc>().add(TaskGetEvent());
            },
            child: BlocConsumer<TaskCrudBloc, TaskCrudState>(
                builder: (context, state) {
              if (state is TaskCrudLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TaskCrudError) {
                return const Text('Some thing get wrong');
              } else if (state is TaskCrudSuccess) {
                final task = state.tasks;
                return ListView.builder(
                    itemCount: task.length,
                    itemBuilder: (context, index) {
                      return TaskCardWidget(
                        title: task[index]['title'],
                        subtitle: task[index]['subtitle'],
                        id: task[index]['id'],
                        onDelete: (value) {
                          context
                              .read<TaskCrudBloc>()
                              .add(TaskDeleteEvent(id: task[index]['id']));
                        },
                        keyValue: task[index]['id'],
                      );
                    });
              }
              return const SizedBox();
            }, listener: (context, state) {
              if (state is TaskCRUDFinish) {
                context.read<TaskCrudBloc>().add(TaskGetEvent());
              }
            }),
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
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate());
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
            heroTag: 'key',
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  isScrollControlled: true,
                  context: context,
                  transitionAnimationController: animationController,
                  builder: (context) {
                    return const TaskAddSheet();
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
