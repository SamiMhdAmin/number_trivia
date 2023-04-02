import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure([List properties = const <dynamic>[] ]);
  //TODO: this code maybe wrong so see the video 2 in min ( around 15 )
  @override
  // TODO: implement props
  List<dynamic> get props => [Failure];
  
}