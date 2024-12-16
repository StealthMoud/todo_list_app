import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskSearchDelegate extends SearchDelegate<dynamic> {
  final List<Task> tasks;

  TaskSearchDelegate(this.tasks);

  @override
  Widget buildLeading(BuildContext context) {
    // The leading widget is the back button or any icon you want at the start of the search.
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions are buttons to clear the search or cancel it.
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clears the search query
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // This is the content to display when the user has submitted a search.
    List<Task> results = tasks
        .where((task) =>
            task.title.contains(query) || task.description.contains(query))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].title),
          subtitle: Text(results[index].description),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This is the content to display while the user is typing the query.
    List<Task> suggestions = tasks
        .where((task) =>
            task.title.contains(query) || task.description.contains(query))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].title),
          subtitle: Text(suggestions[index].description),
          onTap: () {
            query = suggestions[index]
                .title; // or use the task for further interaction
            showResults(context);
          },
        );
      },
    );
  }
}
