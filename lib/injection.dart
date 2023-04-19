import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/core/utils/input_convert.dart';
import 'package:number_trivia/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/use%20cases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use%20cases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presenation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'features/number_trivia/data/datasource/number_trivia_local_data_source.dart';

GetIt locator = GetIt.instance;

Future<void> init() async {
  // Features - Number trivia
  //bloc
  locator.registerFactory(
    () => NumberTriviaBloc(
      getRandomNumberTrivia: locator(),
      getConcreteNumberTrivia: locator(),
      inputConvert: locator(),
    ),
  );

  //use cases
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  //Repository
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: locator(),
      networkInfo: locator(),
      remoteDataSource: locator(),
    ),
  );

  //Data sources
  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: locator()));

  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTrivaiRemoteDataSourceImpl(client: locator()),
  );

  // core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  locator.registerLazySingleton(() => InputConvert());

  //Extenal
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}


/*
what is the diffrence between registerFactory and registerLazySingleton and registerSingleton  ?
 */

/**
 registerFactory and registerLazySingleton and registerSingleton are methods provided by the GetIt package in Dart for registering instances of classes for dependency injection. The main differences between them are:

registerFactory: This method creates a new instance of the registered class each time it is requested. This is useful for classes that need to be created each time they are used, or for cases where creating multiple instances of the same class is not a problem.

registerLazySingleton: This method creates a single instance of the registered class when it is first requested and returns the same instance for all subsequent requests. This is useful for classes that are expensive to create, or for cases where only one instance of a class is needed.

registerSingleton: This method creates a single instance of the registered class at the time of registration and returns the same instance for all subsequent requests. This is useful for classes that are expensive to create and need to be reused throughout the application.

In summary, the main difference between registerLazySingleton and registerSingleton is the timing of the instance creation. registerLazySingleton creates the instance only when it is first requested, while registerSingleton creates it at the time of registration. registerFactory creates a new instance each time it is requested.
 */