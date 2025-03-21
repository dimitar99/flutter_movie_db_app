import 'package:flutter_movie_db_app/layers/data/datasource/movie/source/movie_remote_data_source.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/repository/movie/movie_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImpl({required MovieRemoteDataSource movieRemoteDataSource}) : _movieRemoteDataSource = movieRemoteDataSource;

  @override
  Future<Result<List<MovieEntity>, Exception>> getPopularMovies() async {
    final resp = await _movieRemoteDataSource.getPopularMovies();

    return resp.when(
      (movies) {
        return Success(movies);
      },
      (error) {
        return Error(Exception('Error obtaining popular movies'));
      },
    );
  }

  @override
  Future<Result<List<MovieCreditEntity>, Exception>> getMovieCredits({required int movieId}) async {
    final resp = await _movieRemoteDataSource.getMovieCredits(movieId: movieId);

    return resp.when(
      (credits) {
        return Success(credits);
      },
      (error) {
        return Error(Exception('Error obtaining movie credits'));
      },
    );
  }
}
