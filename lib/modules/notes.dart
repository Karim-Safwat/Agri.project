import 'package:flutter/material.dart';

class Notes_Screen extends StatelessWidget {
  const Notes_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("kariiem mohammed taha Ahmed Taleb",
      style:Theme.of(context).textTheme.bodyText1 ,
      ),
    );
  }
}