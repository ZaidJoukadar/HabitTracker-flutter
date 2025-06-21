import 'package:flutter/material.dart';

class Addbutton extends StatelessWidget {
  final void Function()? onadd;
  const Addbutton({super.key,required this.onadd});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed:onadd ,child: Icon(Icons.add,color: Colors.white,));
  }
}
