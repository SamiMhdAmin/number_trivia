import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

String numberInput = '';

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        onChanged: (value) {
          numberInput = value;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Colors.purple.shade400), //<-- SEE HERE
          ),
          hintText: 'Enter The number trivia',
        ),
      ),
    );
  }
}
