import 'package:faker/faker.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';

int _generatedId = 0;
MovieEntity createMockMovie() {
  _generatedId++;
  return MovieEntity(
    id: _generatedId,
    title: faker.lorem.word(),
    overview: faker.lorem.sentence(),
    posterPath: faker.image.loremPicsum(),
    releaseDate: DateTime.now(),
    voteAverage: faker.randomGenerator.decimal(),
    voteCount: faker.randomGenerator.integer(100),
    backdropPath: faker.image.loremPicsum(),
    genreIds: List.generate(3, (index) => faker.randomGenerator.integer(100)),
    originalLanguage: faker.lorem.word(),
    originalTitle: faker.lorem.word(),
    video: false,
    adult: false,
    popularity: faker.randomGenerator.decimal(),
  );
}

List<MovieEntity> createMockMovies({int movies = 5}) {
  return List.generate(movies, (index) => createMockMovie());
}

List createMockMoviesToJson({int movies = 5}) {
  return List.generate(movies, (index) => createMockMovie().toJson());
}

