import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/exceptions.dart';

import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChoser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRemoteDataSource remoteDataSource;
  NumberTriviaLocalDataSource localDataSource;
  NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    // i think this should be NmberTriviaModel
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async{
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }


  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChoser getConcreteOrRandom
  )async{
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia =
            await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await getConcreteOrRandom();
        return Right(localTrivia);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }
}
