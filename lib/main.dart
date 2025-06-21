import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'Screen/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ///////////// initialize hive
  await Hive.initFlutter();
  await Hive.openBox("Habit_Database");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.green),
          ),
    );
  }
}
