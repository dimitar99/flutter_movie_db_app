import 'package:flutter_movie_db_app/layers/domain/entity/movie_credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/repository/movie/movie_repository.dart';
import 'package:flutter_movie_db_app/layers/domain/usecase/get_movie_credits_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../mocks/movie_credits_mock.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMovieCreditsUsecase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetMovieCreditsUsecase(movieRepository: mockMovieRepository);
  });

  final List<MovieCreditEntity> credits = createMockCredits();
  int movieId = 1;

  group('GetMovieCreditsUsecase Test', () {
    test('Success<List<MovieCreditEntity>> when Respository returns data', () async {
      // Simulate the repository behavior
      when(() => mockMovieRepository.getMovieCredits(movieId: movieId)).thenAnswer((_) async => Success(credits));

      // Execute use case
      final result = await useCase(movieId: movieId);

      // Check result
      expect(result, isA<Success<List<MovieCreditEntity>, Exception>>());
      result.when(
        (successCredits) => expect(successCredits, equals(credits)),
        (exception) => fail('Unexpected error: $exception'),
      );

      // Verify that the repository method was called
      verify(() => mockMovieRepository.getMovieCredits(movieId: movieId)).called(1);
    });

    test('Error<Exception> when Respository returns error', () async {
      // Simulate the repository behavior
      when(() => mockMovieRepository.getMovieCredits(movieId: movieId)).thenAnswer((_) async => Error(Exception('Error')));

      // Execute use case
      final result = await useCase(movieId: movieId);

      // Check result
      expect(result, isA<Error<List<MovieCreditEntity>, Exception>>());
      result.when(
        (successCredits) => fail('Unexpected success: $successCredits'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the repository method was called
      verify(() => mockMovieRepository.getMovieCredits(movieId: movieId)).called(1);
    });
  });
}
