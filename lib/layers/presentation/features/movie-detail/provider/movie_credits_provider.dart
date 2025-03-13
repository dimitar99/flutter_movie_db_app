import 'package:flutter_movie_db_app/layers/domain/entity/credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/usecase/get_movie_credits_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

final movieCreditsProvider = FutureProvider.family<List<CreditEntity>, int>((ref, movieId) async {
  final useCase = GetIt.instance.get<GetMovieCreditsUsecase>();
  final result = await useCase.call(movieId: movieId);

  return result.when(
    (credits) {
      return credits;
    },
    (error) {
      return throw Exception(error);
    },
  );
});
