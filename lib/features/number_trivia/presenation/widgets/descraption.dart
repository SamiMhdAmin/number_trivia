import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class Descraption extends StatelessWidget {
  const Descraption({super.key, required this.numberTrivia});
  final NumberTrivia numberTrivia;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.purple.shade400,
          border: Border.all(
            color: Colors.purple.shade400,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width * .8,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
           numberTrivia.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
