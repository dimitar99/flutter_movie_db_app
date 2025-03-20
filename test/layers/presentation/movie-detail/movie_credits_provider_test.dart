import 'package:flutter_movie_db_app/layers/domain/usecase/get_movie_credits_usecase.dart';
import 'package:flutter_movie_db_app/layers/presentation/features/movie-detail/provider/movie_credits_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../mocks/movie_credits_mock.dart';

class MockGetMovieCreditsUsecase extends Mock implements GetMovieCreditsUsecase {}

void main() {
  late MockGetMovieCreditsUsecase useCase;
  late ProviderContainer container;

  setUp(() {
    useCase = MockGetMovieCreditsUsecase();
    container = ProviderContainer(
      overrides: [
        movieCreditsProvider.overrideWith((ref, movieId) async {
          final result = await useCase.call(movieId: movieId);
          return result.when((credits) => credits, (error) => throw Exception(error));
        }),
      ],
    );

    addTearDown(() => container.dispose());
  });

  const testMovieId = 1;

  group('MovieCreditsProvider Tests', () {
    test('Success<List<MovieCreditEntity>> when usecase returns data', () async {
      final credits = createMockCredits();

      // Simulate the usecase behavior
      when(() => useCase(movieId: testMovieId)).thenAnswer((_) async => Success(credits));

      // Execute provider
      final result = await container.read(movieCreditsProvider(testMovieId).future);

      // Check result
      expect(result, equals(credits));

      // Verify that the usecase method was called
      verify(() => useCase(movieId: testMovieId)).called(1);
    });

    test('Error<Exception> when usecase returns error', () async {
      // Simulate the usecase behavior
      when(() => useCase(movieId: testMovieId)).thenAnswer((_) async => Error(Exception('Request error')));

      // Execute provider && Check result
      expect(container.read(movieCreditsProvider(testMovieId).future), throwsA(isA<Exception>()));

      // Verify that the usecase method was called
      verify(() => useCase(movieId: testMovieId)).called(1);
    });
  });
}
