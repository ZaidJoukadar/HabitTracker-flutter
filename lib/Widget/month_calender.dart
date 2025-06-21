import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:myhabit/DateTime/date_time.dart';

import '../Data/habit_database.dart';

class MonthCalender extends StatelessWidget {
  final String startDate;
  final Map<DateTime, int>? dataset;
  const MonthCalender(
      {super.key, required this.startDate, required this.dataset});

  @override
  Widget build(BuildContext context) {
    DateTime endOfMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    return HeatMap(
      startDate: createDateTimeObject(startDate),
      endDate: endOfMonth,
      datasets: dataset,
      colorMode: ColorMode.color,
      textColor: Colors.white,
      showText: true,
      defaultColor: Colors.grey[200],
      scrollable: true,
      showColorTip: false,
      colorsets: {
        0: Colors.grey[300]!,
        1: Color(0xFFB9F6CA),
        2: Color(0xFF69F0AE),
        3: Color(0xFF00E676),
        4: Color(0xFF00C853),
        5: Color(0xFF00B248),
        6: Color(0xFF009624),
        7: Color(0xFF43A047),
        8: Color(0xFF2E7D32),
        9: Color(0xFF388E3C),
        10: Color(0xFF1B5E20),
      },
      onClick: (date) {
        String formattedDate = convertDateTimeToString(date);

        List? habitList = mybox.get(formattedDate);

        if (habitList == null) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("No Habit"),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.black),
              content: Text(
                "Does not have any habit in this day",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
          );
        } else {
          String tasks = habitList
              .map((task) => "*  ${task[0]}:  ${task[1] ? "✔️" : "❌"}")
              .join("\n");

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title:
                  Text("Day of Habit ${date.day}/${date.month}/${date.year}"),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.black),
              content: Text(
                tasks,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
          );
        }
      },
    );
  }
}
