import 'package:flutter_movie_db_app/layers/data/datasource/movie/source/movie_remote_data_source.dart';
import 'package:flutter_movie_db_app/layers/data/repository/movie/movie_repository_impl.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../mocks/movie_credits_mock.dart';
import '../../../mocks/movie_mock.dart';

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(movieRemoteDataSource: mockDataSource);
  });

  final movies = createMockMovies();
  final credits = createMockCredits();
  int movieId = 1;

  group('MovieRepositoryImpl Tests', () {
    ///
    /// [GetPopularMovies]
    ///
    test('Success<List<MovieEntity>> when repository returns data', () async {
      // Simulate the repository behavior
      when(() => mockDataSource.getPopularMovies()).thenAnswer((_) async => Success(movies));

      // Execute repository
      final resultMovies = await repository.getPopularMovies();

      // Check result
      expect(resultMovies, isA<Success<List<MovieEntity>, Exception>>());
      resultMovies.when(
        (successMovies) => expect(successMovies, equals(movies)),
        (exception) => fail('Unexpected error: $exception'),
      );

      // Verify that the repository method was called
      verify(() => mockDataSource.getPopularMovies()).called(1);
    });

    test('Error<Exception> when repository returns error', () async {
      // Simulate the repository behavior
      when(
        () => mockDataSource.getPopularMovies(),
      ).thenAnswer((_) async => Error(Exception('Error obtaining popular movies')));

      // Execute repository
      final resultMovies = await repository.getPopularMovies();

      // Check result
      expect(resultMovies, isA<Error<List<MovieEntity>, Exception>>());
      resultMovies.when(
        (successMovies) => fail('Unexpected success: $successMovies'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the repository method was called
      verify(() => mockDataSource.getPopularMovies()).called(1);
    });

    //
    /// [GetMovieCredits]
    ///
    test('Success<List<MovieCreditEntity>> when repository returns data', () async {
      // Simulate the repository behavior
      when(() => mockDataSource.getMovieCredits(movieId: movieId)).thenAnswer((_) async => Success(credits));

      // Execute use case
      final resultCredits = await repository.getMovieCredits(movieId: movieId);

      expect(resultCredits, isA<Success<List<MovieCreditEntity>, Exception>>());
      resultCredits.when(
        (successCredits) => expect(successCredits, equals(credits)),
        (exception) => fail('Unexpected error: $exception'),
      );

      // Verify that the repository method was called
      verify(() => mockDataSource.getMovieCredits(movieId: movieId)).called(1);
    });

    test('Error<Exception> when repository returns error', () async {
      // Simulate the repository behavior
      when(
        () => mockDataSource.getMovieCredits(movieId: movieId),
      ).thenAnswer((_) async => Error(Exception('Error obtaining movie credits')));

      // Execute repository
      final resultCredits = await repository.getMovieCredits(movieId: movieId);

      // Check result
      expect(resultCredits, isA<Error<List<MovieCreditEntity>, Exception>>());
      resultCredits.when(
        (successCredits) => fail('Unexpected success: $successCredits'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the repository method was called
      verify(() => mockDataSource.getMovieCredits(movieId: movieId)).called(1);
    });
  });
}
