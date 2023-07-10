import 'package:chat_app/model/todo.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:chat_app/widgets/todo_items.dart';

class Home extends StatefulWidget {
    Home({Key? key}):super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final todolist = ToDo.todolist();
  List<ToDo> foundtodo = [];
  final todocontroller = TextEditingController();


  @override
  void initState() {
    foundtodo = todolist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: my_bg,
      appBar: buildAppBar(),
      body:Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          "All Todos",
                          style: TextStyle(
                            fontSize:30,
                            color: my_black,
                            fontWeight: FontWeight.w500,
                          ),),
                      ),
                      for(ToDo todo in foundtodo)
                        todoitem(
                          todo: todo,
                        onTodochange: handleTodoChange,
                        onDeleteItem: deleteToDoItems,),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:const [BoxShadow(
                      offset: Offset(0.0,0.0),
                      blurRadius:10.0,
                      spreadRadius:0.0,)],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todocontroller,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo items',
                      border: InputBorder.none
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text('+',style: TextStyle(fontSize: 40),),
                    onPressed: (){
                      addItems(todocontroller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: my_blue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
  void runFilter(String keywords){
    List<ToDo> result = [];
    if (keywords.isEmpty){
      result = todolist;
    }else{
      result = todolist.where((item) => item.todotext!
        .toLowerCase().contains(keywords.toLowerCase()))
    .toList();
    }
    setState(() {
      foundtodo = result;
    });
  }

  void addItems(String todo){
    setState(() {
    todolist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todotext: todo));
    });
    todocontroller.clear();
  }

void deleteToDoItems(String id){
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
}

  void handleTodoChange(ToDo todo){
    setState(() {
    todo.isDone = !todo.isDone;
    });
  }

  Container searchbox() {
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              onChanged: (value) => runFilter(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search,
                color: my_black,
                size: 20,),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 18,
                  maxWidth: 25
                ),
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: my_grey)
              ),
            ),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor:  my_bg,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,color: my_black,size: 30,),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:Image.asset("assets/images/avatar_2.jpg"),)
          )
        ],
      ),
    );
  }
}