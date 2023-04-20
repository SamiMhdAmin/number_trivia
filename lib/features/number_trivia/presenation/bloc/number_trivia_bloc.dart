import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/core/utils/input_convert.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use%20cases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use%20cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final InputConvert inputConvert;

  NumberTriviaBloc({
    required this.getRandomNumberTrivia,
    required this.getConcreteNumberTrivia,
    required this.inputConvert,
  }) : super(NumberTriviaInitial()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      emit(NumberTriviaLoading());
      // Your event handling logic goes here.
      final inputEither = inputConvert.stringToUnsignedInteger(event.number);
      await inputEither.fold((failure) {
        emit(NumberTriviaFailure(msg: "invalid input failure"));
        // yield NumberTriviaFailure(msg: "there is error");
      }, (integer) async {
        emit(NumberTriviaLoading());
        final failureOrTrivia =
            await getConcreteNumberTrivia.execute(Params(number: integer));
        print(failureOrTrivia);
        /*await*/ failureOrTrivia.fold((failure) {
          emit(NumberTriviaFailure(msg: "Cache or network failure"));
        }, (trivia) /*async*/ {
          print('trivia: ${trivia.number} and ${trivia.text} and $trivia');
          /*await Future.delayed(Duration(milliseconds: 500));*/
          emit(NumberTriviaSuccess(numberTrivia: trivia));
        });
      });
//         }
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      // Your event handling logic goes here.
      emit(NumberTriviaLoading());
      final failureOrTrivia = await getRandomNumberTrivia.execute(NoParams());
      print(failureOrTrivia);
      failureOrTrivia.fold((failure) {
        emit(NumberTriviaFailure(msg: "Cache or network failure"));
      }, (trivia) {
        emit(NumberTriviaSuccess(numberTrivia: trivia));
      });
    });
  }
}
