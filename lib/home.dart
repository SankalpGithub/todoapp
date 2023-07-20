import 'package:chat_app/model/todo.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:intl/intl.dart';
import 'package:chat_app/widgets/todo_items.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = ToDo.todolist();
  List<ToDo> foundtodo = [];
  final todocontroller = TextEditingController();
  late DateTime time;
  late String date;
  String deadline = "";

  @override
  void initState() {
    foundtodo = todolist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: my_bg,
      appBar: buildAppBar(),
      body: Column(
        children: [
          //search box
          Container(
            width: 450,
            height: 50,
            padding: EdgeInsets.only(top: 5, right: 15, left: 15),
            color: my_bg,
            child: searchbox(),
          ),
          //todo text
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            color: my_bg,
            width: 450,
            child: Text(
              "All Todos",
              style: TextStyle(
                fontSize: 30,
                color: my_black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //if empty
          if (todolist.isEmpty)
            Container(
              child: Text(
                'Add Tasks',
                style: TextStyle(
                  fontSize: 15,
                  color: my_grey,
                ),
              ),
            ),
          Container(
            child: Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 500,
                  child: ListView(
                    children: [
                      for (ToDo todo in foundtodo.reversed)
                        todoitem(
                          todo: todo,
                          onTodochange: handleTodoChange,
                          onDeleteItem: deleteToDoItems,
                        ),
                    ],
                  ),
                )),
          ),
          //input
          Row(
            children: [
              Container(
                height: 60,
                width: 300,
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      )
                    ]),
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 237,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter Task", border: InputBorder.none),
                          controller: todocontroller,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            DateTime? datepicker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2023 + 100));

                            deadline = DateFormat.yMMMd()
                                .format(datepicker!)
                                .toString();
                          },
                          icon: Icon(Icons.date_range))
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: my_blue, borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    if (todocontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Enter your task",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }else {
                      print(todolist);
                      time = DateTime.now();
                      date = DateFormat('jm').format(time);
                      addItems(todocontroller.text.toString());
                    }

                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void runFilter(String keywords) {
    List<ToDo> result = [];
    if (keywords.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((item) =>
          item.todotext!.toLowerCase().contains(keywords.toLowerCase()))
          .toList();
    }
    setState(() {
      foundtodo = result;
    });
  }

  void addItems(String todo){
    if(deadline == ""){
      deadline = "no deadline";
    }

    setState(() {
      todolist.add(ToDo(
          id: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          todotext: todo,
          date: date,
          deadline: deadline));

    });
    todocontroller.clear();
    deadline = "";
  }

  void deleteToDoItems(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  void handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  Container searchbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: my_black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 18, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: my_grey)),
      ),
    );
  }

  AppBar buildAppBar() {

    return AppBar(
      backgroundColor: my_bg,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu,
                color: my_black,
                size: 30,)
          ),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/avatar_2.jpg"),
              ))
        ],
      ),
    );
  }
}