import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/movie.dart';
import '../widgets/movie_tile.dart';
import 'add_movie_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900], // Set AppBar background color
        title: Text(
          'Movie Watchlist',
          style: TextStyle(color: Colors.white), // Set AppBar text color
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // Set icon color
            onPressed: () {
              context.read<AuthService>().signOut();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: FirestoreService.getMovies(), // Use FirestoreService
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final movies = snapshot.data ?? [];
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: MovieTile(movie: movie, index: index),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900], // Set FAB background color
        child: Icon(Icons.add, color: Colors.white), // Set FAB icon color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMovieScreen()),
          );
        },
      ),
    );
  }
}
