import 'package:equatable/equatable.dart';
//maybe this code is wrong..in video 2 ;
class NumberTrivia extends Equatable {
  int number;
  String text;
  NumberTrivia({
    required this.number,
    required this.text,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props =>[number,text];
}
