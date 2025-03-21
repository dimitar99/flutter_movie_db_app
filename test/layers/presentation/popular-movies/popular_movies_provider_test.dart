import 'package:flutter_movie_db_app/layers/domain/usecase/get_popular_movies_usecase.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/popular_movies/providers/popular_movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../mocks/movie_mock.dart';

class MockGetPopularMoviesUseCase extends Mock implements GetPopularMoviesUseCase {}

void main() {
  late MockGetPopularMoviesUseCase useCase;
  late ProviderContainer container;

  setUp(() {
    useCase = MockGetPopularMoviesUseCase();
    container = ProviderContainer(
      overrides: [
        popularMovieListProvider.overrideWith((ref) async {
          final result = await useCase.call();
          return result.when((movies) => movies, (error) => throw Exception(error));
        }),
      ],
    );

    addTearDown(() => container.dispose());
  });

  group('PopularMoviesProvider Tests', () {
    test('Success<List<MovieEntity>> when usecase returns data', () async {
      final movies = createMockMovies();

      // Simulate the usecase behavior
      when(() => useCase()).thenAnswer((_) async => Success(movies));

      // Execute provider
      final result = await container.read(popularMovieListProvider.future);

      // Check results
      expect(result, equals(movies));

      // Verify that usecase method was called
      verify(() => useCase()).called(1);
    });

    test('Error<Exception> when usecase returns error', () async {
      // Simulate the usecase behavior
      when(() => useCase()).thenAnswer((_) async => Error(Exception('Request error')));

      // Execute provider && Check result
      expect(container.read(popularMovieListProvider.future), throwsA(isA<Exception>()));

      // Verify that the usecase method was called
      verify(() => useCase()).called(1);
    });
  });
}
