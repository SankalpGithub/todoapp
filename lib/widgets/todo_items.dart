import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';
class todoitem extends StatelessWidget {
  const todoitem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
      onTap: (){},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      tileColor: Colors.white,
        leading: Icon(Icons.check_box,
          color: my_blue,
        ),
          title:Text(
              "check mail",
          style: TextStyle(
            fontSize: 16,
            color: my_black,
            decoration: TextDecoration.lineThrough,
          ),),
          trailing: Container(
          height: 35,
            width: 35,
            decoration: BoxDecoration(
              color:my_red,
              borderRadius:BorderRadius.circular(5)
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('clicked'),));
            },
            ),
      ),
      ),
    );
  }
}
