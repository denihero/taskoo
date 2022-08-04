import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
          },
          icon: const Icon(Icons.search))
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
        Expanded(child: Text('Wait'))
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
