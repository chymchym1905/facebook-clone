import 'package:flutter/material.dart';

class Watch extends StatelessWidget{
  const Watch({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('2nd page'),
      ),
      body: Center(
        child: Text(data),
      )
    );
  }
}