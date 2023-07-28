import 'package:hive_flutter/hive_flutter.dart';
class ToDo{
  List todolist = [];

    final mybox = Hive.box('mybox');

    void createInitialData() {
      todolist = [
        ["somework","no deadline","5:44 PM",false,"id"],
        ["anywork","Jul 22, 2023","5:42 AM",true,"id1"],
      ];
    }
    void loaddata(){
      todolist = mybox.get("TODOLIST");
    }
    void updatedata(){
      mybox.put("TODOLIST",todolist);
    }
  }