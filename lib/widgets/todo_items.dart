import 'package:chat_app/model/colors.dart';
import 'package:chat_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/model/todo.dart';

class todoitem extends StatelessWidget {
  final String taskname;
  final String date;
  final String time;
  final int index;
  final bool iscomplete;
  Function(bool?)? onChanged;
  final deleteFunction;


  todoitem({
    super.key,
    required this.taskname,
    required this.date,
    required this.time,
    required this.index,
    required this.iscomplete,
    required this.onChanged,
    required this.deleteFunction,
  });
  ToDo td = ToDo();
  @override
  Widget build(BuildContext context) {
    return
      Container(

      margin: EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 80,
        child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
          leading:  Checkbox(
            value: iscomplete,
            onChanged: onChanged,
            activeColor: Colors.black,
          ),


            title:Text(taskname,
            style: TextStyle(
              fontSize: 16,
              color: my_black,
              decoration:iscomplete?TextDecoration.lineThrough:TextDecoration.none,
            ),),


          subtitle: Text(
              date,style: TextStyle(color: my_grey),),


            trailing: Column(
              children: [
                Container(
                  margin:EdgeInsets.symmetric(vertical: 5),
                height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius:BorderRadius.circular(5)
                  ),
                  child: IconButton(
                    color: my_black,
                    iconSize: 18,
                    icon: Icon(Icons.delete),
                    onPressed:(){
                     deleteFunction(index);
                    },
                  ),
        ),

                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    time,style: TextStyle(fontSize: 12,color:my_grey),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
