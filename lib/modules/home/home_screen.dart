import 'package:flutter/material.dart';
import 'package:flutter_movies/modules/home/home_controller.dart';
import 'package:flutter_movies/modules/movie_detail/movie_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController get controller => context.read<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.loadUpcoming();
    controller.loadPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff21232A),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xff21232A),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '  Upcoming movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Consumer<HomeController>(
              builder: (context, controller, child) {
                if (controller.upcomingLoading) {
                  return const CircularProgressIndicator();
                }
                final items = controller.upcoming?.results;
                if (items == null) {
                  return const Text('Server error');
                }
                return SizedBox(
                  height: 160,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${item.posterPath}',
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Text(
              '  Popular movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Consumer<HomeController>(
              builder: (context, controller, child) {
                if (controller.popularLoading) {
                  return const CircularProgressIndicator();
                }
                if (controller.popular == null ||
                    controller.popular!.results.isEmpty) {
                  return const Text('Server error');
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: controller.popular!.results.length,
                    itemBuilder: (context, index) {
                      final item = controller.popular!.results[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: item),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500/${item.posterPath}',
                                height: 100,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.originalTitle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 24,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: item.voteAverage.toString(),
                                          style: const TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '(${item.voteCount})',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
