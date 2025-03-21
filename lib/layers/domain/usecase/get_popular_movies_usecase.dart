import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/repository/movie/movie_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable()
class GetPopularMoviesUseCase {
  final MovieRepository _movieRepository;

  GetPopularMoviesUseCase({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  Future<Result<List<MovieEntity>, Exception>> call() async {
    return await _movieRepository.getPopularMovies();
  }
}
 