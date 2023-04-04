import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia,Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);
  
  @override
  Future<Either<Failure, NumberTrivia>> execute(Params params) async{
    return await repository.getConcreteNumberTrivia(params.number);
  }
}  

class Params extends Equatable{

  final int number;

  Params(this.number);
  @override
  // this is the correct way to use the package i am asked chat gpt
  List<Object?> get props => [number];

}