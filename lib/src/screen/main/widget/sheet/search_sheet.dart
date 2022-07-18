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
            context.read<TaskCrudBloc>().add(TaskSearchEvent());
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
      children: [
        Expanded(
          child: BlocBuilder<TaskCrudBloc, TaskCrudState>(
            builder: (context, state) {
              if(state is TaskCrudLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is TaskCrudError){
                return const Center(
                  child: Text('Some error happened'),
                );
              }else if(state is TaskSearchSuccess){
                final task = state.tasks;
                print(task);
                return ListView.builder(
                    itemCount: task.length,
                    itemBuilder: (context, index) {
                      return TaskCardWidget(
                          title: task[index]['title'],
                          subtitle: task[index]['subtitle'],
                          keyValue: task[index]['id'],
                          onDelete: (s) {

                          },
                          id: task[index]['id']
                      );
                    }
                );
              }
              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
