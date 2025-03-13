import 'package:flutter_movie_db_app/layers/domain/entity/credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class MovieRemoteDataSource {
  Future<Result<List<MovieEntity>, Exception>> getPopularMovies();
  Future<Result<List<CreditEntity>, Exception>> getMovieCredits({required int movieId});
}