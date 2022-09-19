import 'package:flutter/material.dart';
import 'package:flutter_movies/data/models/movies.dart';
import 'package:flutter_movies/modules/movie_detail/movie_detail_controller.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String name = 'movie-detail';

  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailController get controller => context.read<MovieDetailController>();

  @override
  void initState() {
    super.initState();
    //
    controller.loadDetail(widget.movie.id);
    controller.loadCredits(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff21232A),
      appBar: AppBar(
        backgroundColor: const Color(0xff21232A),
        title: Text(widget.movie.originalTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<MovieDetailController>(
                builder: (context, controller, child) {
                  if (controller.detailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.detail == null) {
                    return const Text('Server error');
                  }
                  final detail = controller.detail!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500/${widget.movie.backdropPath}',
                        width: double.infinity,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.movie.originalTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            detail.releaseDate.year.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${detail.runtime}m',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(detail.overview),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              Consumer<MovieDetailController>(
                builder: (context, controller, child) {
                  if (controller.creditsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.credits == null) {
                    return const Text('Server Error');
                  }
                  final credits = controller.credits!;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: credits.cast.length,
                              itemBuilder: (context, index) {
                                final cast = credits.cast[index];
                                return Text(cast.name);
                              },
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Cast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: credits.crew.length > 10
                                  ? 10
                                  : credits.crew.length,
                              itemBuilder: (context, index) {
                                final crew = credits.crew[index];
                                return Text(crew.name);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
