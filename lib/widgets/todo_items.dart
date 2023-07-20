import 'package:chat_app/colors.dart';
import 'package:chat_app/home.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';
class todoitem extends StatelessWidget {
  final ToDo todo;
  final onTodochange;
  final onDeleteItem;
  const todoitem({Key? key,required this.todo,required this.onTodochange,required this.onDeleteItem}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Container(
        height: 80,
        child: ListTile(
        onTap: (){
          onTodochange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
          leading: Icon(todo.isDone?Icons.check_box:Icons.check_box_outline_blank,
            color: my_blue,
          ),
            title:Text(
                todo.todotext!,
            style: TextStyle(
              fontSize: 16,
              color: my_black,
              decoration:todo.isDone? TextDecoration.lineThrough:null,
            ),),
          subtitle: Text(
            todo.deadline
          ),
            trailing: Column(
              children: [
                Container(
                  margin:EdgeInsets.symmetric(vertical: 5),
                height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:my_red,
                    borderRadius:BorderRadius.circular(5)
                  ),
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 18,
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      onDeleteItem(todo.id);
                  },
                  ),
        ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    todo.date.toString(),style: TextStyle(fontSize: 12,color:Colors.grey),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
