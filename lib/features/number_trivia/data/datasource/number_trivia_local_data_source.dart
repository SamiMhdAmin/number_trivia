import 'dart:convert';

import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';

import '../../domain/entities/number_trivia.dart';

// this should be correct
abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
  // 90% this should to be NumberTrivia because thats how i fixed the error but keep that in your mind
  //but in the code it's NumberTriviaModel
}

const cachedNumberTrivia = 'CACHED';

class NumberTriviaLocalDataSourceImpl extends NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache){

    //the next 3 line it's a code i write to do the same function
    // final String triviaToCacheAsJson = triviaToCache.toJson().toString();
    // // Save an String value to 'action' key.
    // await sharedPreferences.setString('action', triviaToCacheAsJson);

    return sharedPreferences.setString(cachedNumberTrivia, jsonEncode(triviaToCache));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(cachedNumberTrivia)));
    } else {
      throw CacheExeption();
    }
  }
}
