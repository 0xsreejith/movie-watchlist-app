import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/movie_controller.dart';
import '../models/movie_model.dart';

class MovieListView extends StatelessWidget {
  final MovieController controller = Get.put(MovieController());

  MovieListView({super.key});

  // Helper function to validate and clean image URLs
  String? _validateImageUrl(String url) {
    if (url.trim().isEmpty) return null;
    return url.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.movie, color: Colors.amber, size: 24),
            const SizedBox(width: 8),
            Text(
              'Watchlist',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade900.withOpacity(0.7), Colors.black],
          ),
        ),
        child: Obx(() {
          if (controller.movies.isEmpty) {
            return _buildEmptyState();
          }
          return _buildMovieList(context);
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMovieDialog(context),
        backgroundColor: Colors.amber.shade700,
        icon: const Icon(Icons.add, color: Colors.black),
        label: Text(
          'Add Movie',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.movie_outlined,
              size: 60,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No movies yet!',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to start adding.',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 120, left: 16, right: 16, bottom: 80),
      itemCount: controller.movies.length,
      itemBuilder: (context, index) {
        final movie = controller.movies[index];
        return Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.grey.shade900.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(18),
            leading: _buildLeadingWidget(movie, index),
            title: Text(
              movie.title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                decoration: movie.watched ? TextDecoration.lineThrough : null,
                color: movie.watched ? Colors.grey : Colors.white,
              ),
            ),
            subtitle: _buildSubtitle(movie),
            trailing: _buildTrailingWidget(context, movie, index),
            onTap: () => controller.toggleWatched(index),
          ),
        );
      },
    );
  }

  Widget _buildLeadingWidget(Movie movie, int index) {
    if (movie.imageUrl != null && movie.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          movie.imageUrl!,
          width: 60,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.broken_image, color: Colors.white54),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => controller.toggleWatched(index),
      child: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          color: movie.watched ? Colors.green.shade600 : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          movie.watched ? Icons.check : Icons.movie,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildSubtitle(Movie movie) {
    final widgets = <Widget>[];

    if (movie.note != null && movie.note!.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            movie.note!,
            style: GoogleFonts.poppins(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    if (movie.rating != null && movie.rating! > 0) {
      widgets.add(
        Row(
          children: [
            RatingBarIndicator(
              rating: movie.rating ?? 0,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 18,
              unratedColor: Colors.amber.withAlpha(60),
            ),
            const SizedBox(width: 8),
            Text(
              movie.rating!.toStringAsFixed(1),
              style: GoogleFonts.poppins(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildTrailingWidget(BuildContext context, Movie movie, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blueAccent),
          onPressed: () => _showEditMovieDialog(context, movie, index),
          tooltip: 'Edit',
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => _showDeleteConfirmation(context, movie, index),
          tooltip: 'Delete',
        ),
      ],
    );
  }

  void _showAddMovieDialog(BuildContext context) {
    _showMovieDialog(context, null, null);
  }

  void _showEditMovieDialog(BuildContext context, Movie movie, int index) {
    _showMovieDialog(context, movie, index);
  }

  void _showMovieDialog(BuildContext context, Movie? movie, int? index) {
    final titleController = TextEditingController(text: movie?.title ?? '');
    final noteController = TextEditingController(text: movie?.note ?? '');
    final imageUrlController = TextEditingController(
      text: movie?.imageUrl ?? '',
    );
    double rating = movie?.rating ?? 0;
    final isEdit = movie != null && index != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEdit ? 'Edit Movie' : 'Add a Movie',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Movie Title
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Movie Title',
                  hintText: 'Enter movie name',
                  prefixIcon: const Icon(Icons.movie, color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                  labelStyle: const TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 16),

              // Notes
              TextField(
                controller: noteController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Notes (optional)',
                  hintText: 'E.g., Watch with friends',
                  prefixIcon: const Icon(Icons.note, color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.purple),
                  ),
                  labelStyle: const TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 16),

              // Image URL
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: imageUrlController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Image URL (optional)',
                      hintText: 'https://example.com/movie-poster.jpg',
                      prefixIcon: const Icon(
                        Icons.image,
                        color: Colors.white54,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                      labelStyle: const TextStyle(color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tip: Use direct image URLs ending in .jpg, .png, or .webp',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Example: https://picsum.photos/300/450',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Rating
              Row(
                children: [
                  const Text(
                    'Rating:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 28,
                    unratedColor: Colors.amber.withAlpha(60),
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (value) => rating = value,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final note = noteController.text.trim();
                        final imageUrl = _validateImageUrl(
                          imageUrlController.text,
                        );

                        if (title.isEmpty) return;

                        final newMovie = Movie(
                          title: title,
                          note: note.isNotEmpty ? note : null,
                          watched: movie?.watched ?? false,
                          imageUrl: imageUrl,
                          rating: rating > 0 ? rating : null,
                        );

                        if (isEdit) {
                          controller.updateMovie(index, newMovie);
                        } else {
                          controller.addMovie(newMovie);
                        }

                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isEdit ? 'Update' : 'Save',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Movie movie, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Movie',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Are you sure you want to delete "${movie.title}" from your watchlist?\n\nThis action cannot be undone.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.deleteMovie(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
