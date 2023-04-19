import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presenation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presenation/widgets/custom_text_field.dart';
import 'package:number_trivia/features/number_trivia/presenation/widgets/descraption.dart';
import 'package:number_trivia/features/number_trivia/presenation/widgets/row_buttons.dart';
import 'package:number_trivia/injection.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NumberTriviaBloc>(
      create: (context) => locator<NumberTriviaBloc>(),
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          if (state is NumberTriviaInitial) {
            return Column(
              children:const [
                SizedBox(
                  height: 16,
                ),
                CustomTextField(),
                 SizedBox(
                  height: 16,
                ),
                 RowButtons()
              ],
            );
          }
          if (state is NumberTriviaSuccess) {
            print(' i am in state success');
            NumberTrivia number = state.numberTrivia;
            return Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Text(number.number.toString()),
                const SizedBox(
                  height: 16,
                ),
                Descraption(numberTrivia: state.numberTrivia),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(),
                const SizedBox(
                  height: 16,
                ),
                const RowButtons()
              ],
            );
          } else if (state is NumberTriviaFailure) {
            print(' i am in state Failure');

            return Text(state.msg);
          } else {
            print(' i am in loading');

            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(),
                  const SizedBox(
                    height: 16,
                  ),
                  RowButtons()
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
