import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  int number;
  String text;
  NumberTrivia({
    required this.number,
    required this.text,
  });
  
  @override
  List<Object?> get props =>[number,text];
}
