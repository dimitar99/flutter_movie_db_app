import 'package:flutter_movie_db_app/layers/domain/entity/movie_credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/repository/movie/movie_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

@Injectable()
class GetMovieCreditsUsecase {
  final MovieRepository _movieRepository;

  GetMovieCreditsUsecase({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  Future<Result<List<MovieCreditEntity>, Exception>> call({required int movieId}) async {
    return await _movieRepository.getMovieCredits(movieId: movieId);
  }
}
