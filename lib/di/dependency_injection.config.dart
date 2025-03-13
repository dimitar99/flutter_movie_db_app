// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_movie_db_app/layers/data/datasource/movie/source/movie_remote_data_source.dart'
    as _i304;
import 'package:flutter_movie_db_app/layers/data/repository/movie/movie_repository_impl.dart'
    as _i500;
import 'package:flutter_movie_db_app/layers/domain/modules/movie_remote_datasource_module.dart'
    as _i207;
import 'package:flutter_movie_db_app/layers/domain/repository/movie/movie_repository.dart'
    as _i963;
import 'package:flutter_movie_db_app/layers/domain/usecase/get_movie_credits_usecase.dart'
    as _i880;
import 'package:flutter_movie_db_app/layers/domain/usecase/get_popular_movies_usecase.dart'
    as _i983;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final movieRemoteDatasourceModule = _$MovieRemoteDatasourceModule();
    gh.factory<_i304.MovieRemoteDataSource>(
      () => movieRemoteDatasourceModule.movieRemoteDatasource,
    );
    gh.factory<_i963.MovieRepository>(
      () => _i500.MovieRepositoryImpl(
        movieRemoteDataSource: gh<_i304.MovieRemoteDataSource>(),
      ),
    );
    gh.factory<_i880.GetMovieCreditsUsecase>(
      () => _i880.GetMovieCreditsUsecase(
        movieRepository: gh<_i963.MovieRepository>(),
      ),
    );
    gh.factory<_i983.GetPopularMoviesUseCase>(
      () => _i983.GetPopularMoviesUseCase(
        movieRepository: gh<_i963.MovieRepository>(),
      ),
    );
    return this;
  }
}

class _$MovieRemoteDatasourceModule extends _i207.MovieRemoteDatasourceModule {}
