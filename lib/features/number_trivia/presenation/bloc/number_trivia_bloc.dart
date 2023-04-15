import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/core/utils/input_convert.dart';

import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use%20cases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use%20cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final InputConvert inputConvert;
  NumberTriviaBloc({
    required this.getRandomNumberTrivia,
    required this.getConcreteNumberTrivia,
    required this.inputConvert,
  }) : super(NumberTriviaInitial()) {
    on<NumberTriviaEvent>((event, emit) async {
      if (event is GetTriviaForConcreteNumber) {
        final inputEither = inputConvert.stringToUnsignedInteger(event.number);
        inputEither.fold((failure) async* {
          emit(NumberTriviaFailure(msg: "invalid input failure"));
          // yield NumberTriviaFailure(msg: "there is error");
        }, (integer) async* {
          emit(NumberTriviaLoading());
          final failureOrTrivia =
              await getConcreteNumberTrivia.execute(Params(integer));
          yield failureOrTrivia.fold((failure) {
            emit(NumberTriviaFailure(msg: "Cache or network failure"));
          }, (trivia) {
            emit(NumberTriviaSuccess(numberTrivia: trivia));
          });
        });
      } else if (event is GetTriviaForRandomNumber) {
        (integer) async* {
          emit(NumberTriviaLoading());
          final failureOrTrivia =
              await getRandomNumberTrivia.execute(NoParams());
          yield failureOrTrivia.fold((failure) {
            emit(NumberTriviaFailure(msg: "Cache or network failure"));
          }, (trivia) {
            emit(NumberTriviaSuccess(numberTrivia: trivia));
          });
        };
      }
    });
  }
}


/*
  on<NumberTriviaEvent>((event, emit) async{
      if (event is GetTriviaForConcreteNumber) {
        final inputEither = inputConvert.stringToUnsignedInteger(event.number);
       yield* inputEither.fold((failure) async* {
          yield NumberTriviaFailure(msg: "there is error");
        }, (integer) {});
      }
    });

 */

//  on<AuthEvent>((event, emit) async{
//       if(event is LoginEvent){
//         emit(LoginLoading());
//     try {
//       UserCredential user = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: event.email, password: event.password);
//       emit(LoginSuccess());
//     } on FirebaseAuthException catch (ex) {
//       if (ex.code == 'user-not-found') {
//         emit(LoginFailure(errMessage: 'user-not-found'));
//       } else if (ex.code == 'wrong-password') {
//         emit(LoginFailure(errMessage: 'wrong-password'));
//       }
//     } catch (e) {
//       emit(LoginFailure(errMessage: 'there was an error'));
//     }
//       }
//     });