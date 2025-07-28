import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  bool watched;

  @HiveField(3)
  String? imageUrl;

  @HiveField(4)
  double? rating;

  Movie({
    required this.title,
    this.note,
    this.watched = false,
    this.imageUrl,
    this.rating,
  });
}
