import 'package:flutter/material.dart';
import 'package:taskoo/src/screen/main/widget/top_is_scroll_icon.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 35,
          ),
         const TopIsScrollIcon(),
          userProfile(context),
          taskNews(
              icon: const Icon(
                Icons.inbox,
                color: Colors.blueAccent,
              ),
              title: const Text('Входящие'),
              onTap: () {}),
          taskNews(
              icon: Stack(
                children: const [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.greenAccent,
                  ),
                  Positioned(
                      top: 9,
                      left: 9,
                      child: Text(
                        '9',
                        style:
                            TextStyle(fontSize: 11, color: Colors.greenAccent),
                      ))
                ],
              ),
              title: const Text('Сегодня'),
              onTap: () {}),
          taskNews(
              icon: const Icon(
                Icons.calendar_month,
                color: Colors.purpleAccent,
              ),
              title: const Text('Предстоящее'),
              onTap: () {}),
        ],
      ),
    );
  }

  Widget userProfile(BuildContext context) {
    return ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent,
        ),
        title: const Text(
          'Deni Hero',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
        subtitle: const Text('0/4'),
        trailing: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/setting');
          },
          icon: const Icon(
            Icons.settings,
            size: 27,
          ),
        ));
  }

  Widget taskNews(
      {required Widget icon,
      required Widget title,
      required Function() onTap}) {
    return ListTile(
      dense: false,
      leading: icon,
      title: Transform.translate(offset: const Offset(-16, 0), child: title),
      onTap: onTap,
    );
  }
}
