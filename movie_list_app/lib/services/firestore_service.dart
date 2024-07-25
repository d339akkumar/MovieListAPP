import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference moviesCollection =
      _firestore.collection('movies');

  static Future<void> addMovie(Movie movie) async {
    try {
      await moviesCollection.add(movie.toFirestore());
    } catch (e) {
      print('Error adding movie: $e');
    }
  }

  static Future<List<Movie>> getMovies() async {
    try {
      final QuerySnapshot result = await moviesCollection.get();
      final List<Movie> movies = result.docs.map((doc) {
        return Movie.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
      return movies;
    } catch (e) {
      print('Error getting movies: $e');
      return [];
    }
  }

  static Future<void> deleteMovie(String docId) async {
    try {
      await moviesCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting movie: $e');
    }
  }
}
