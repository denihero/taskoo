import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskoo/src/screen/bloc/cubit/search_cubit.dart';
import 'package:taskoo/src/screen/main/widget/task_card.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {
      BlocProvider.of<SearchCubit>(context).searchTask(query);
    }, icon: const Icon(Icons.search))
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
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if(state is SearchLoaded){
                final searchResult = state.tasks;
                return ListView.builder(
                  itemCount: searchResult.length,
                    itemBuilder:(context,index){
                      return TaskCardWidget(
                        title: searchResult[index]['title'],
                        subtitle: searchResult[index]['subtitle'],
                        id: searchResult[index]['id'],
                        onDelete: (value) {

                        },
                        keyValue: searchResult[index]['id'],
                      );
                    }
                );
              }else if(state is SearchLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is SearchError){
                return const Center(
                  child: Text('Something get wrong'),
                );
              }
              return const SizedBox();

            },
          ),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    BlocProvider.of<SearchCubit>(context).searchTask(query);
    if (query.length > 2) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoaded) {
                  final searchResult = state.tasks;
                  return ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) {
                        return TaskCardWidget(
                          title: searchResult[index]['title'],
                          subtitle: searchResult[index]['subtitle'],
                          id: searchResult[index]['id'],
                          onDelete: (value) {

                          },
                          keyValue: searchResult[index]['id'],
                        );
                      }
                  );
                } else if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchError) {
                  return const Center(
                    child: Text('Something get wrong'),
                  );
                }else if(state is SearchEmpty){
                  return Align(
                    alignment: Alignment.topCenter  ,
                      child: Text(
                        'По запросу $query ничего не найдено',
                        style: const TextStyle(fontSize: 17),
                      ),
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      );
    }
    return const SizedBox();
  }
}
