import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'movie_list_view.dart'; // If MovieListView is in a separate file

class MovieSearch extends SearchDelegate<Movie?> {
  final List<Movie> movies;

  MovieSearch(this.movies);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter the movies list based on the search query
    final results = movies.where((movie) =>
        movie.title.toLowerCase().contains(query.toLowerCase())).toList();

    return MovieListView(movies: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show some suggestions based on the search query
    final suggestions = movies.where((movie) =>
        movie.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion.title),
          onTap: () {
            query = suggestion.title;
            showResults(context);
          },
        );
      },
    );
  }
}
