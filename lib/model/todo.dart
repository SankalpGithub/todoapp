class ToDo{
  String? id;
  String? todotext;
  String date;
  String deadline;
  bool isDone;

  ToDo({required this.id,
    required this.date,
    required this.deadline,
      required this.todotext,
      this.isDone = false});

  static List<ToDo> todolist(){
    return [];
  }
}