import 'package:faker/faker.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_credits_entity.dart';

int _generatedId = 0;
MovieCreditEntity createMockCredit() {
  _generatedId++;
  return MovieCreditEntity(
    adult: faker.randomGenerator.boolean(),
    gender: faker.randomGenerator.integer(2),
    id: _generatedId,
    knownForDepartment: faker.lorem.word(),
    name: faker.lorem.word(),
    originalName: faker.lorem.word(),
    popularity: faker.randomGenerator.decimal(),
    profilePath: faker.image.loremPicsum(),
    castId: faker.randomGenerator.integer(10),
    character: faker.lorem.word(),
    creditId: faker.lorem.word(),
    order: faker.randomGenerator.integer(10),
  );
}

List<MovieCreditEntity> createMockCredits({int credits = 5}) {
  return List.generate(credits, (index) => createMockCredit());
}

List createMockCreditsToJson({int credits = 5}) {
  return List.generate(credits, (index) => createMockCredit().toJson());
}

