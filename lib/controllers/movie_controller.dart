import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/hive_service.dart';

class MovieController extends GetxController {
  final HiveService _hiveService = HiveService();
  var movies = <Movie>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await _hiveService.init();
    loadMovies();
  }

  void loadMovies() {
    movies.value = _hiveService.getAllMovies();
  }

  Future<void> addMovie(Movie movie) async {
    await _hiveService.addMovie(movie);
    loadMovies();
  }

  Future<void> updateMovie(int index, Movie movie) async {
    await _hiveService.updateMovie(index, movie);
    loadMovies();
  }

  Future<void> deleteMovie(int index) async {
    await _hiveService.deleteMovie(index);
    loadMovies();
  }

  Future<void> toggleWatched(int index) async {
    await _hiveService.toggleWatched(index);
    loadMovies();
  }

  @override
  void onClose() {
    _hiveService.close();
    super.onClose();
  }
}
