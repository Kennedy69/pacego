import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pacego/dashboard/home.dart';
import 'package:pacego/dashboard/orders.dart';
import 'package:pacego/provider/userprovider.dart';
import 'package:pacego/screensfolder/getstarted.dart';
import 'package:pacego/provider/userprovider.dart';
import 'package:provider/provider.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

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
//   String username ="";
//   String email ="";

// getUserInfo() async{
//  final user = await FirebaseAuth.instance.currentUser;

//  if (user !=null){
//   setState(() {
//     username = user.displayName!;
//     email = user.email!;
//   });
//  }
// }

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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Home();
              }));
            },
            leading: Icon(Icons.home,size: 25.0,color: Color(0xFF049FA3) ,
            ),
            title: Text("Home", style: TextStyle(color:  Color(0xFF049FA3),fontSize: 20.0,fontWeight: FontWeight.w800,
            ),
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Orders();
              }));
            },
            leading: Icon(Icons.bike_scooter,size: 25.0,color: Color(0xFF049FA3) ,
            ),
            title: Text("Orders", style: TextStyle(color:  Color(0xFF049FA3),fontSize: 20.0,fontWeight: FontWeight.w800,
            ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.feedback,size: 25.0,color: Color(0xFF049FA3) ,
            ),
            title: Text("FeedBack", style: TextStyle(color:  Color(0xFF049FA3),fontSize: 20.0,fontWeight: FontWeight.w800,
            ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.wallet,size: 25.0,color: Color(0xFF049FA3) ,
            ),
            title: Text("Wallet", style: TextStyle(color:  Color(0xFF049FA3),fontSize: 20.0,fontWeight: FontWeight.w800,
            ),
            ),
            trailing: Text("Coming Soon",style: TextStyle(
              color:  Color(0xFF049FA3),fontSize: 14.0,fontWeight: FontWeight.bold,
            ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.share,size: 25.0,color: Color(0xFF049FA3) ,
            ),
            title: Text("Share", style: TextStyle(color:  Color(0xFF049FA3),fontSize: 20.0,fontWeight: FontWeight.w800,
            ),
            ),
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
    );
  }
}