import 'package:flutter/material.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/movie/movie_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Movie Db App',
      home: MoviePage(),
    );
  }
}
