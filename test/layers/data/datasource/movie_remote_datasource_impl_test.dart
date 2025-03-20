import 'package:dio/dio.dart';
import 'package:flutter_movie_db_app/layers/data/datasource/movie/remote/movie_remote_data_source_impl.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../mocks/movie_credits_mock.dart';
import '../../../mocks/movie_mock.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MovieRemoteDataSourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = MovieRemoteDataSourceImpl(dio: mockDio);
  });

  final moviesToJson = createMockMoviesToJson();
  final movieData = {'results': moviesToJson};
  final movies = moviesToJson.map((e) => MovieEntity.fromJson(e)).toList();

  final creditsToJson = createMockCreditsToJson();
  final creditsData = {'cast': creditsToJson};
  final credits = creditsToJson.map((e) => MovieCreditEntity.fromJson(e)).toList();

  int movieId = 1;

  group('MovieRemoteDatasourceImpl Tests', () {
    ///
    /// [GetPopularMovies]
    ///
    test('Success<List<MovieEntity>> when datasource returns data', () async {
      // Simulate the dio behavior
      when(
        () => mockDio.get(any()),
      ).thenAnswer((_) async => Response(data: movieData, statusCode: 200, requestOptions: RequestOptions(path: '')));

      // Execute datasource
      final resultMovies = await datasource.getPopularMovies();
 
      // Check result
      expect(resultMovies, isA<Success<List<MovieEntity>, Exception>>());
      resultMovies.when(
        (successMovies) => expect(successMovies, equals(movies)),
        (exception) => fail('Unexpected error: $exception'),
      );

      // Verify that the dio was called
      verify(() => mockDio.get(any())).called(1);
    });

    test('Error<Exception> when datasource returns error', () async {
      // Simulate the dio behavior
      when(() => mockDio.get(any())).thenThrow(Exception('Error obtaining popular movies'));

      // Execute datasource
      final resultMovies = await datasource.getPopularMovies();

      // Check result
      expect(resultMovies, isA<Error<List<MovieEntity>, Exception>>());
      resultMovies.when(
        (successMovies) => fail('Unexpected success: $successMovies'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the dio was called
      verify(() => mockDio.get(any())).called(1);
    });

    test('DioException when request fails returns error', () async {
      // Simulate the dio behavior
      when(
        () => mockDio.get(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: ''), error: 'Network error'));

      // Execute datasource
      final resultMovies = await datasource.getPopularMovies();

      // Check result
      expect(resultMovies, isA<Error<List<MovieEntity>, Exception>>());
      resultMovies.when(
        (successMovies) => fail('Unexpected success: $successMovies'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the dio was called
      verify(() => mockDio.get(any())).called(1);
    });

    ///
    /// [GetMovieCredits]
    ///
    test('Success<List<MovieCreditEntity>> when datasource returns data', () async {
      // Simulate the dio behavior
      when(
        () => mockDio.get(any()),
      ).thenAnswer((_) async => Response(data: creditsData, statusCode: 200, requestOptions: RequestOptions(path: '')));

      // Execute datasource
      final resultCredits = await datasource.getMovieCredits(movieId: movieId);

      // Check result
      expect(resultCredits, isA<Success<List<MovieCreditEntity>, Exception>>());
      resultCredits.when(
        (successCredits) => expect(successCredits, equals(credits)),
        (exception) => fail('Unexpected error: $exception'),
      );

      // Verify that the dio was called
      verify(() => mockDio.get(any())).called(1);
    });

    test('Error<Exception> when datasource returns error', () async {
      // Simulate the dio behavior
      when(() => mockDio.get(any())).thenThrow(Exception('Error obtaining movie credits'));

      // Execute datasource
      final resultCredits = await datasource.getMovieCredits(movieId: movieId);

      // Check result
      expect(resultCredits, isA<Error<List<MovieCreditEntity>, Exception>>());
      resultCredits.when(
        (successCredits) => fail('Unexpected success: $successCredits'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the dio was called
      verify(() => mockDio.get(any())).called(1);
    });

    test('DioException when request fails returns error', () async {
      // Simulate the dio behavior
      when(
        () => mockDio.get(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: ''), error: 'Network error'));

      // Execute datasource
      final resultCredits = await datasource.getMovieCredits(movieId: movieId);

      // Check result
      expect(resultCredits, isA<Error<List<MovieCreditEntity>, Exception>>());
      resultCredits.when(
        (successMovies) => fail('Unexpected success: $successMovies'),
        (exception) => expect(exception, isA<Exception>()),
      );

      // Verify that the dio was called
      verify(() => mockDio.get(any())).called(1);
    });
  });
}
