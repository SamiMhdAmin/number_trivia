import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presenation/widgets/home_body.dart';

class HomeTrivia extends StatelessWidget {
  const HomeTrivia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple.shade400),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Number Trivia'),
          backgroundColor: Colors.purple.shade400,
        ),
        body: const HomeBody(),
      ),
    );
  }
}