
import 'package:chat_app/model/todo.dart';
import 'package:flutter/material.dart';
import '../model/colors.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chat_app/widgets/todo_items.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 ToDo td = ToDo();
 List foundtodo = [];
 final myBox = Hive.box('mybox');
  final todocontroller = TextEditingController();
  late String time = "";
   String deadline = "";
   FocusNode focus = FocusNode();
   bool bottombar = true;

  @override
  void initState() {
    if (myBox.get("TODOLIST") == null) {
      td.createInitialData();
    } else {
      // there already exists data
      td.loaddata();
    }
    foundtodo = td.todolist;
  }


 @override
  void dispose() {
    super.dispose();
    focus.removeListener(() {bottombar = true;setState(() {
    });});
    focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: my_bg,
        body:
      GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        child: SafeArea(
          child: Column(
              children: [
                //search box
                Container(

                  padding: EdgeInsets.only(bottom: 2,right: 15,left: 15),
                  height: 100,
                  color: my_bg,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color: my_bg,
                        child: Text(
                          "Todos",
                          style: TextStyle(
                            fontSize: 35,
                            color: my_black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 35,
                        color: my_bg,
                        child: searchbox(),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  height: 10,
                  color: my_grey,
                  thickness: 2,
                ),
                //todo text
                //if empty
                if (td.todolist.isEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      'Add Tasks',
                      style: TextStyle(
                        fontSize: 15,
                        color: my_black,
                      ),
                    ),
                  ),
                Container(
                  child: Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
                        height: 500,
                        child: ListView.builder(
                          itemCount: foundtodo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return todoitem(
                                taskname: foundtodo[index][0],
                                date: foundtodo[index][1],
                                time: foundtodo[index][2],
                                index: index,
                                iscomplete: foundtodo[index][3],
                                onChanged: (value) => handleTodoChange(value, index),
                                deleteFunction: deleteFunction);
                          },

                        ),
                      )),
                ),
                //input

                //
                 Visibility(
                   visible: bottombar,
                   child: Row(
                   children: [
                   Container(
              height: 60,
            width: 300,
            padding: EdgeInsets.only(left: 15),
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),),
            child: Center(
            child: Row(
            children: [
            Container(
            height: 50,
            width: 237,
            child: TextField(
            decoration: InputDecoration(
            hintText: "Enter Task", border: InputBorder.none),
            controller: todocontroller,),),
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
            color: my_black, borderRadius: BorderRadius.circular(5)),
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
            if(todocontroller.text.isEmpty){
            Fluttertoast.showToast(
            msg: "Enter some task",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: my_grey,
            textColor: Colors.white,
            fontSize: 16.0
            );
            }else{
            time = DateFormat("jm").format(DateTime.now());
            addItems(todocontroller.text.toString());
              }
                },
                    ),
                      ),
                        ],
                          ),
                 )
                ],
              ),
        ),
        ),
        );
    }


  void addItems(String todo){
    if(deadline == ""){
      deadline = "no deadline";
    }
    setState(() {
      td.todolist.add(
          [todo,deadline,time,false,DateTime.now()]
      );
    deadline = "";
    });
    todocontroller.clear();
    td.updatedata();
  }

  Container searchbox() {
    return Container(
      decoration: BoxDecoration(
          color: my_search),
      child: Focus(
        onFocusChange: (value) => bottom(value),
        child: TextField(
          onChanged: (value) => runFilter(value),
          focusNode: focus,
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: my_black,
                size: 20,
              ),
              prefixIconConstraints: BoxConstraints(maxHeight: 18, maxWidth: 25),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: my_black,fontSize: 15)),
        ),
      ),
    );
  }

  handleTodoChange(bool? value, int index) {
    setState(() {
      td.todolist[index][3] = !td.todolist[index][3];
    });
    td.updatedata();
  }

  deleteFunction(int index) {
    setState(() {
      td.todolist.removeAt(index);
    });
    td.updatedata();
  }

  runFilter(String keywords) {
    List result = [];
    if (keywords.isEmpty) {
      result = td.todolist;
    } else {
      for(int i = 0;i <td.todolist.length;i++){
        if(td.todolist[i][0].contains(keywords)){
          result.add(td.todolist[i]);
        }
      }
    }
    setState(() {
      foundtodo = result;
    });
  }
  
  void bottom(bool value){
    if(value){
      bottombar = false;
    }else{
      bottombar = true;
    }
    setState(() {});
  }
}