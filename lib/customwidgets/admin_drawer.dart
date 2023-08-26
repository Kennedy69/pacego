import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userprovider.dart';
import '../screensfolder/getstarted.dart';


class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {

  logout ()async{

    try{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
     return GetStarted();
    }));
    }
     catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Er",style: TextStyle(
              color: Colors.white,fontSize: 13.0,fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          ),
          );
      
     }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
          width: double.infinity,
          height: 150.0,
          color:  Color(0xFF049FA3),

         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.person,color: Colors.white,size: 40.0,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.read<UserProvider>().getUsername.toString(), style: TextStyle(
              color: Colors.white, fontSize: 17.0,fontWeight: FontWeight.w700,
              ),
              ),

              Text(context.read<UserProvider>().getEmail.toString(), style: TextStyle(
              color: Colors.white, fontSize: 14.0,fontWeight: FontWeight.w500,
              ),
              ),

            ],
            ),
          ],
         ),
          ),
          SizedBox(height: 30.0,
          ),
       

      ListTile(
        onTap:(){
          logout();
        },
            leading: Icon(Icons.logout,size: 25.0,color: Colors.red ,
            ),
            title: Text("Logout", style: TextStyle(color:  Colors.red,fontSize: 20.0,fontWeight: FontWeight.w800,
            ),
            ),
          ),
        ],
      ),
    );;
  }
}