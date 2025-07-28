import 'package:hive/hive.dart';
import '../models/movie_model.dart';

class HiveService {
  static const String boxName = 'movies';
  late Box<Movie> movieBox;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MovieAdapter());
    }
    movieBox = await Hive.openBox<Movie>(boxName);
  }

  List<Movie> getAllMovies() {
    return movieBox.values.toList();
  }

  Future<void> addMovie(Movie movie) async {
    await movieBox.add(movie);
  }

  Future<void> updateMovie(int index, Movie movie) async {
    await movieBox.putAt(index, movie);
  }

  Future<void> deleteMovie(int index) async {
    await movieBox.deleteAt(index);
  }

  Future<void> toggleWatched(int index) async {
    final movie = movieBox.getAt(index);
    if (movie != null) {
      movie.watched = !movie.watched;
      await movie.save();
    }
  }

  Future<void> close() async {
    await movieBox.close();
  }
}
