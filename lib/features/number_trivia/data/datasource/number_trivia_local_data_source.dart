import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';

import '../../domain/entities/number_trivia.dart';
//this should be correct
abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
  // 90% this should to be NumberTrivia because thats how i fixed the error but keep that in your mind
  //but in the code it's NumberTriviaModel
}