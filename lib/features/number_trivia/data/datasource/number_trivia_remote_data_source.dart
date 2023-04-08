import 'dart:convert';

import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  //maybe this should be numberTrivia model
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTrivaiRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTrivaiRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    /*
    String url = "http://numbersapi.com/$number";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<NumberTriviaModel> numbersTrivia = [];
    for (var singleNumberTrivia in responseData) {
      NumberTriviaModel user = NumberTriviaModel(
        number: singleNumberTrivia["number"],
        text: singleNumberTrivia["text"],
      );

      //Adding user to the list.
      numbersTrivia.add(user);
    }
    return numbersTrivia[0];
    */

    return _getNumberTriviaByUrl("http://numbersapi.com/$number");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    /*
    String url = "http://numbersapi.com/random";
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<NumberTriviaModel> numbersTrivia = [];
    for (var singleNumberTrivia in responseData) {
      NumberTriviaModel numberDetails = NumberTriviaModel(
        number: singleNumberTrivia["number"],
        text: singleNumberTrivia["text"],
      );

      //Adding user to the list.
      numbersTrivia.add(numberDetails);
    }
    return numbersTrivia[0];*/
    return _getNumberTriviaByUrl("http://numbersapi.com/random");
  }

  Future<NumberTriviaModel> _getNumberTriviaByUrl(String fullUrl) async {
    var url = Uri.parse(fullUrl);
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerExeption();
    }
  }
}
