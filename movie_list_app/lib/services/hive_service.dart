import 'package:hive/hive.dart';
import '../models/movie.dart';

class HiveService {
  static const String _boxName = 'movieBox';

  static Future<void> initHive() async {
    Hive.registerAdapter(MovieAdapter());
    await Hive.openBox<Movie>(_boxName);
  }

  static Box<Movie> get movieBox => Hive.box<Movie>(_boxName);

  static Future<void> addMovie(Movie movie) async {
    await movieBox.add(movie);
  }

  static Future<void> deleteMovie(int index) async {
    await movieBox.deleteAt(index);
  }

  static Future<List<Movie>> getMovies() async {
    return movieBox.values.toList();
  }
}
