import 'package:flutter/material.dart';
import 'package:flutter_movie_db_app/di/dependency_injection.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/popular_movies/popular_movies_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Flutter Movie Db App', home: MoviePage());
  }
}
