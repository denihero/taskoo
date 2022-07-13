import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);
  final String title;
  final String subtitle;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      leading: Checkbox(
        value: false,
        onChanged: (value) {

        },
        shape: const CircleBorder(),
      ),
      title: Text(title),
      subtitle: Column(
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
              style: const TextStyle(
                  fontSize: 12
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: const Offset(15,5),
              child: SizedBox(
                width: 100,
                child: Row(
                  children: const [
                    Text('Входящие',style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13
                    ),),
                    Icon(Icons.inbox,size: 15,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
