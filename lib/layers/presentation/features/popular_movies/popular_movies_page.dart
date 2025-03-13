import 'package:flutter/material.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/movie-detail/movie_detail.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/popular_movies/providers/popular_movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends ConsumerStatefulWidget {
  const MoviePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(popularMovieListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies'), centerTitle: true),
      body: movies.when(
        data: (movies) => _listview(movies),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  ListView _listview(List<MovieEntity> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetail(movie: movie)),
            );
          },
        );
      },
    );
  }
}
