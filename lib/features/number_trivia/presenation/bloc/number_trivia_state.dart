part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {
  //const NumberTriviaInitial(super.numberTrivia);
}

class NumberTriviaLoading extends NumberTriviaState {
  //const NumberTriviaLoading(super.numberTrivia);
}

class NumberTriviaSuccess extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  NumberTriviaSuccess({
    required this.numberTrivia,
  });

  @override
  List get props => [numberTrivia];
}

class NumberTriviaFailure extends NumberTriviaState {
  final String msg;
  NumberTriviaFailure({
    required this.msg,
  });

  @override
  List get props => [msg];
}
