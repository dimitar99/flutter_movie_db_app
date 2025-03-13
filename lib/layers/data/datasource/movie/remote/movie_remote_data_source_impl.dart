import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_movie_db_app/layers/data/datasource/movie/source/movie_remote_data_source.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/credits_entity.dart';
import 'package:flutter_movie_db_app/layers/domain/entity/movie_entity.dart';
import 'package:multiple_result/multiple_result.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSourceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<Result<List<MovieEntity>, Exception>> getPopularMovies() async {
    try {
      Response resp = await _dio.get('/movie/popular');

      if (resp.statusCode == 200) {
        List results = resp.data['results'];

        if (results.isNotEmpty) {
          return Success(results.map((e) => MovieEntity.fromJson(e)).toList());
        }
      }

      return Error(Exception('No movies found'));
    } catch (e) {
      log(e.toString());
      throw Exception('Error obtaing popular movies');
    }
  }

  @override
  Future<Result<List<CreditEntity>, Exception>> getMovieCredits({required int movieId}) async {
    try {
      Response resp = await _dio.get('/movie/$movieId/credits');

      if (resp.statusCode == 200) {
        List results = resp.data['cast'];

        if (results.isNotEmpty) {
          return Success(results.map((e) => CreditEntity.fromJson(e)).toList());
        }
      }

      return Error(Exception('No credits found'));
    } catch (e) {
      log(e.toString());
      throw Exception('Error obtaing movie credits');
    }
  }
}
