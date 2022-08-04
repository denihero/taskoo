import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/src/screen/bloc/crud_task/task_crud_bloc.dart';
import 'package:taskoo/src/screen/main/widget/task_card.dart';


class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            print(query);
          },
          icon: const Icon(Icons.search)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    BackButton(onPressed: () {
      close(context, '');
    });
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Text('Wait')
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
