import 'package:hive/hive.dart';
import 'package:myhabit/DateTime/date_time.dart';

final mybox= Hive.box("Habit_Database");

class HabitDatabase{
  List HabitList=[];
  Map<DateTime,int> heatMapSet={};

  ///////// Create initial data
void createdefaultData(){
  HabitList=[
    ["Run",false],
    ["Read",false]
  ];
  mybox.put("Start_Date", todaysDateFormatted());
}
////////////// load data if it exists
void loadData(){
//////////////// if it's a new day
if(mybox.get(todaysDateFormatted())==null){
  HabitList=mybox.get("Cureent_Habit_List");
  ////////// set all Habit completed to false since it;s a new day
  for(int i=0; i< HabitList.length;i++){
    HabitList[i][1]=false;
  }
}
else{
  HabitList=mybox.get(todaysDateFormatted());
}
}
////////////// update database
void updateDate(){
  /////////////// update habit entry
  mybox.put(todaysDateFormatted(), HabitList);
  /////////////////// update universial habit
  mybox.put("Cureent_Habit_List", HabitList);

  calculateHabitPresentage();

  loadHabitMap();
}
void calculateHabitPresentage(){
  int countcomplete=0;
  for(int i=0; i<HabitList.length;i++){
    if(HabitList[i][1]==true){
      countcomplete++;
    }
  }
  String presentage= HabitList.isEmpty?'0.0':(countcomplete/HabitList.length).toStringAsFixed(1);
  mybox.put("summery_presentage_${todaysDateFormatted()}",presentage);
}
  void loadHabitMap() {
    DateTime startDate = createDateTimeObject(mybox.get("Start_Date"));
    int daysInBetween = DateTime.now().difference(startDate).inDays;
    heatMapSet.clear();

    for (int i = 0; i <= daysInBetween; i++) {
      DateTime currentDay = startDate.add(Duration(days: i));
      String yyyymmdd = convertDateTimeToString(currentDay);

      String percentString = mybox.get("summery_presentage_$yyyymmdd") ?? "0.0";
      double strength = double.tryParse(percentString) ?? 0.0;

      heatMapSet[DateTime(currentDay.year, currentDay.month, currentDay.day)] =
          (10 * strength).toInt();
    }

    print("🔥 heatMapSet: $heatMapSet");
  }
}