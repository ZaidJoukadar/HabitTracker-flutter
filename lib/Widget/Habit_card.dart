// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitCard extends StatelessWidget {
  final String Habitname;
  final bool Habitcomplete;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? onsetting;
  final void Function(BuildContext)? ondelete;
  const HabitCard(
      {super.key,
      required this.Habitname,
      required this.Habitcomplete,
      required this.onChanged,
      required this.onsetting,
      required this.ondelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
              onPressed: onsetting,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings),
          SlidableAction(
              onPressed: ondelete,
              backgroundColor: Colors.redAccent,
              icon: Icons.delete),
        ]),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(
                value: Habitcomplete,
                onChanged: onChanged,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.green; // عند التحديد
                  }
                  return Colors.grey.shade100; // عند عدم التحديد
                }),
              ),
              Text(
                Habitname,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
