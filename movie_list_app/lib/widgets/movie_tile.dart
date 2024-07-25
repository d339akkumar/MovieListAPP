import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/hive_service.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final int index;

  MovieTile({required this.movie, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      leading: movie.posterUrl.isNotEmpty
          ? Image.network(movie.posterUrl, width: 50, fit: BoxFit.cover)
          : Placeholder(fallbackWidth: 50),
      title: Text(movie.name),
      subtitle: Text(movie.director),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await HiveService.deleteMovie(index);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Movie deleted')),
          );
        },
      ),
    );
  }
}
