part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaSuccess extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  NumberTriviaSuccess({
    required this.numberTrivia,
  });
}

class NumberTriviaFailure extends NumberTriviaState {
  final String msg;
  NumberTriviaFailure({
    required this.msg,
  });
}

