import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final popularMovieListProvider = FutureProvider<List<MovieEntity>>((ref) async {
  final useCase = GetIt.instance.get<GetPopularMoviesUseCase>();
  final result = await useCase.call();

  return result.when(
    (movies) {
      return movies;
    },
    (error) {
      return throw Exception(error);
    },
  );
});
