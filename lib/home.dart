import 'package:flutter/material.dart';
import 'colors.dart';

class my_home extends StatelessWidget {
  const my_home({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: my_bg,
      appBar: buildAppBar(),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
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
            )
          ],
        ),
      )
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