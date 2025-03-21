import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/repository/movie/movie_repository.dart';
import 'package:flutter_movie_db_app/layers/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../mocks/movie_mock.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPopularMoviesUseCase useCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetPopularMoviesUseCase(movieRepository: mockMovieRepository);
  });

  final List<MovieEntity> movies = createMockMovies();

  group('GetPopularMoviesUseCase Test', () {
    test('Success<List<MovieCreditEntity>> when respository returns data', () async {
      // Simulate the repository behavior
      when(() => mockMovieRepository.getPopularMovies()).thenAnswer((_) async => Success(movies));

      // Execute use case
      final result = await useCase();

      // Check resultc
      expect(result, isA<Success<List<MovieEntity>, Exception>>());
      result.when(
        (successMovies) => expect(successMovies, equals(movies)),
        (exception) => fail('Unexpected error: $exception'),
      );

      // Verify that the repository method was called
      verify(() => mockMovieRepository.getPopularMovies()).called(1);
    });

    test('Error<Exception> when Respository returns error', () async {
      // Simulate the repository behavior
      when(() => mockMovieRepository.getPopularMovies()).thenAnswer((_) async => Error(Exception('Error')));

      // Execute use case
      final result = await useCase();

      // Check resultc
      expect(result, isA<Error<List<MovieEntity>, Exception>>());
      result.when(
        (successMovies) => fail('Unexpected success: $successMovies'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the repository method was called
      verify(() => mockMovieRepository.getPopularMovies()).called(1);
    });
  });
}
