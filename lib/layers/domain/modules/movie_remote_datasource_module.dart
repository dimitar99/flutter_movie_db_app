import 'package:flutter_movie_db_app/core/config/network/dio_service.dart';
import 'package:flutter_movie_db_app/layers/data/datasource/movie/remote/movie_remote_data_source_impl.dart';
import 'package:flutter_movie_db_app/layers/data/datasource/movie/source/movie_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@module
abstract class MovieRemoteDatasourceModule {
  MovieRemoteDataSource get movieRemoteDatasource => MovieRemoteDataSourceImpl(dio: DioService.dio);
}
