class ToDo{
  String? id;
  String? todotext;
  bool isDone;

  ToDo({required this.id,
      required this.todotext,
      this.isDone = false});

  static List<ToDo> todolist(){
    return [
      ToDo(id: '0', todotext: 'morning Exercise', isDone: true),
      ToDo(id: '1', todotext: 'Buy Groceries', isDone: true),
      ToDo(id: '2', todotext: 'check Emails'),
      ToDo(id: '3', todotext: 'Team Meeting'),
      ToDo(id: '4', todotext: 'Work on mobile apps for two hours'),
      ToDo(id: '5', todotext: 'Dinner with Jenny'),
    ];
  }
}