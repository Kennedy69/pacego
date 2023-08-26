import 'package:flutter/material.dart';
import 'package:pacego/auth/login.dart';
import 'package:pacego/auth/register.dart';



class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF1E4854), 

      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
        Center(
        child: Image(
          fit: BoxFit.contain,
          image: NetworkImage("https://res.cloudinary.com/edifice-solutions/image/upload/v1680642543/Group_2_1_vo9yzo.png"),
          ),
      ),
        SizedBox(
         height: 100.0,
        ),
         GestureDetector(
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context){
            return Login();
            }));
          },

          
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: Color(0xFF049FA3),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text("Existing User", style: TextStyle(
                color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold,
              ),
              ),
             ),
           ),
         ),

         GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
          return Register();
            }));
          },
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: Color(0xFF049FA3),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text("New User", style: TextStyle(
                color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold,
              ),
              ),
             ),
           ),
         ),
      
        ],
      ),
    );
  }
}