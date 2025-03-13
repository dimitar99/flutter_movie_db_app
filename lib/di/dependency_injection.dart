import 'package:flutter_movie_db_app/di/dependency_injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
void configureDependencies() => GetIt.instance.init();