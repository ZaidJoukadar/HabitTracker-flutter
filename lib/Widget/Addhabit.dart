import 'package:flutter/material.dart';

class Addhabit extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final void Function()? onsave;
  final void Function()? oncancel;
  const Addhabit({super.key, required this.textEditingController,required this.onsave,required this.oncancel, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        style: TextStyle(color: Colors.white),
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          )
        ),
      ),
      actions: [
        MaterialButton(onPressed: onsave,color: Colors.black,child: Text("Save",style: TextStyle(color: Colors.white),),),
        MaterialButton(onPressed: oncancel,color: Colors.black,child: Text("Cancel",style: TextStyle(color: Colors.white),),)
      ],
    );
  }
}
