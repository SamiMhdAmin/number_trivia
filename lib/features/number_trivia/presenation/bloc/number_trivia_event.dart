part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class getTriviaForConcreteNumber extends NumberTriviaEvent {
  final String number;

  getTriviaForConcreteNumber(this.number);
}

class getTriviaForRandomNumber extends NumberTriviaEvent {}
