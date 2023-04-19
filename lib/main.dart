import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/presenation/pages/home.dart';
import 'injection.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const HomeTrivia());
}

