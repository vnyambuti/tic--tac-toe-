import 'package:flutter/material.dart';

class Flashcardview extends StatelessWidget {
  final String text;

  Flashcardview({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(text,textAlign: TextAlign.center,),
      ),
    );
  }
}
