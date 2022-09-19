import 'package:flutter/material.dart';
import 'package:flutter_movies/data/providers/movie_provider.dart';
import 'package:flutter_movies/modules/home/home_controller.dart';
import 'package:flutter_movies/modules/home/home_screen.dart';
import 'package:flutter_movies/modules/movie_detail/movie_detail_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (ctx) => HomeController(movieProvider: MovieProvider()),
      ),
      ChangeNotifierProvider(
        create: (ctx) => MovieDetailController(movieProvider: MovieProvider()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: const Color(0xff21232A),

        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      home: const HomeScreen(),
    );
  }
}
