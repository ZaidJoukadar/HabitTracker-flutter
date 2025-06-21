import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myhabit/Data/habit_database.dart';
import 'package:myhabit/Widget/AddButton.dart';
import 'package:myhabit/Widget/Addhabit.dart';
import 'package:myhabit/Widget/month_calender.dart';
import '../Widget/Habit_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _mybox = Hive.box("Habit_Database");

  @override
  void initState() {
    if (_mybox.get("Cureent_Habit_List") == null) {
      db.createdefaultData();
    } else {
      db.loadData();
    }
    db.updateDate();
    super.initState();
  }

  void checkBoxtapped(bool? value, int index) {
    setState(() {
      db.HabitList[index][1] = value;
      db.updateDate();
    });
  }

  final textcontroller = TextEditingController();
  void createnewhabit() {
    showDialog(
        context: context,
        builder: (context) {
          return Addhabit(
              hinttext: 'Enter Your Habit',
              textEditingController: textcontroller,
              onsave: savehabit,
              oncancel: canclehabit);
        });
    db.updateDate();
  }

  void deletehabit(int index) {
    setState(() {
      db.HabitList.removeAt(index);
      db.updateDate();
    });
  }

  void savehabit() {
    if (textcontroller.text.isNotEmpty) {
      setState(() {
        db.HabitList.add([textcontroller.text, false]);
        db.updateDate();
        textcontroller.clear();
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void saveexisthabit(int index) {
    setState(() {
      db.HabitList[index][0] = textcontroller.text;
      db.updateDate();
    });
    textcontroller.clear();
    Navigator.of(context).pop();
  }

  void canclehabit() {
    textcontroller.clear();
    Navigator.of(context).pop();
  }

  void openhabitsetting(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return Addhabit(
              hinttext: db.HabitList[index][0],
              textEditingController: textcontroller,
              onsave: () => saveexisthabit(index),
              oncancel: () => canclehabit);
        });
    db.updateDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Addbutton(onadd: () {
          createnewhabit();
        }),
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            MonthCalender(
                startDate: _mybox.get('Start_Date'), dataset: db.heatMapSet),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: db.HabitList.length,
                itemBuilder: (context, index) {
                  return HabitCard(
                    Habitname: db.HabitList[index][0],
                    Habitcomplete: db.HabitList[index][1],
                    onChanged: (value) => checkBoxtapped(value, index),
                    onsetting: (context) => openhabitsetting(index),
                    ondelete: (context) => deletehabit(index),
                  );
                }),
          ],
        ));
  }
}
