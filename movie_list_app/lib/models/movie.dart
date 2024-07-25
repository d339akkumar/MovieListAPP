import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String director;

  @HiveField(2)
  final String posterUrl;

  Movie({required this.name, required this.director, required this.posterUrl});

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'director': director,
      'posterUrl': posterUrl,
    };
  }

  factory Movie.fromFirestore(Map<String, dynamic> data) {
    return Movie(
      name: data['name'],
      director: data['director'],
      posterUrl: data['posterUrl'],
    );
  }
}
