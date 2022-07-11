import 'package:flutter/material.dart';
import 'package:taskoo/src/screen/main/widget/menu_bottom_sheet.dart';
import 'package:taskoo/src/screen/main/widget/task_add_sheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final FocusNode addTaskFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Taskoo'),
        ),
        body: Column(
          children: [],
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
            clipBehavior: Clip.hardEdge,
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
                        onPressed: () {},
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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                elevation: 0,
                isScrollControlled: true,
                barrierColor: Colors.black38,
                context: context,
                builder: (context) {
                  return TaskAddSheet(focusNode: addTaskFocusNode);
                });
          },
          isExtended: true,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
