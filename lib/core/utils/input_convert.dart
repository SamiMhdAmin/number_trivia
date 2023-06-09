import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure.dart';

class InputConvert {
  Either<Failure,int> stringToUnsignedInteger(String str){
    try {
      final integer = int.parse(str);
      if(integer < 0){
        throw FormatException();
      }
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure{}