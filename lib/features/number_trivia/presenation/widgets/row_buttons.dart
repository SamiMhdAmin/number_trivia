import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presenation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presenation/widgets/custom_text_field.dart';

class RowButtons extends StatefulWidget {
  const RowButtons({super.key});

  @override
  State<RowButtons> createState() => _RowButtonsState();
}

class _RowButtonsState extends State<RowButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*.4 ,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple.shade400)),
            onPressed: () {
              print('sami');
              return dispatchConcrete(numberInput);
            },
            child: const Text('Get number Trivia'),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*.4,
          height: 50,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              'Get random number Trivia',
              style: TextStyle(color: Colors.purple.shade400),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  void dispatchConcrete(var number){
    print('number: $number');
    // BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForConcreteNumber(number));
    context.read<NumberTriviaBloc>().add(GetTriviaForConcreteNumber(number));
  }
}
