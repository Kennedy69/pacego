import 'package:flutter/material.dart';
import 'package:pacego/provider/dropprovider.dart';
import 'package:provider/provider.dart';



class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List category = [
    "Clothings",
    "Shoes",
    "Electronics",
    "Jewelries/Accessories",
    "Documents",
    "Health",
    "Products",
    "Computer Accessories",
    "Phone",
    "Food",
    "Frozen Food",
    "Others",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text("Items(s) Category",style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0,
        ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854)
      ),

      body: ListView.builder(
        shrinkWrap: true,
        itemCount: category.length,
        itemBuilder: (BuildContext context, index) {
          return Row(
            children: [
              Checkbox(
                side: BorderSide(
                  color: Color(0xFF049FA3),
                  width: 2.0,
                ),
                value: context.watch<DropOffProvider>().getCategoryList.contains(category[index]),
                onChanged: (value){
               context.read<DropOffProvider>().updateCategoryList(category[index]);

              }
              ),
              Text(category[index].toString(), style: TextStyle(
                color: Colors.white,fontSize: 17.0,fontWeight: FontWeight.w700,
              ),
              ),
            ],
          );
          
        } )
        
    );
  }
}