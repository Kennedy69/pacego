

import 'package:flutter/material.dart';
import 'package:pacego/admin/adminhome.dart';
import 'package:pacego/auth/forgot.dart';
import 'package:pacego/dashboard/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pacego/provider/userprovider.dart';
import 'package:provider/provider.dart';




class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); 
   
   bool showPassword = false;


  showIcon(){
    if(showPassword == true){
      return GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Icon(Icons.visibility,size:
         25.0,color: Colors.white,),
         );
    }
    else{
      return GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Icon(Icons.visibility_off,
        size:25.0,color: Colors.white,
        ),
      );
    }
   }

   signIn() async{

    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email:emailController.text, 
        password: passwordController.text);

        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {

         context.read<UserProvider>().setusername(user.displayName.toString());

         context.read<UserProvider>().setEmail(user.email.toString());

         if(user.email.toString() == "admin@pacego.com"){

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return AdminHome();
        }));
         }
         else{
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return Home();
        }));
         }
       

       
         }
    }
     on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found"){
        // print("User not in database");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "User not found",style: TextStyle(
              color: Colors.white,fontSize: 13.0,fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          ),
          );
      
      }
      else if(e.code == "wrong-password") {
        // print("Invalid Password");
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Invalid Password",style: TextStyle(
              color: Colors.white,fontSize: 13.0,fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          ),
          );
      }
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
     

      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Center(
         child: Image(
          fit: BoxFit.contain,
          image: NetworkImage("https://res.cloudinary.com/edifice-solutions/image/upload/v1680642543/Group_2_1_vo9yzo.png"
          ),
          ),
         ), 
         
         Form(
          key: loginKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
             TextFormField(
              
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500,
                ),
              decoration: InputDecoration(
                hintText: "Email Address ",
                hintStyle: TextStyle(
                color: Colors.white,
                ),
                filled: true,
                fillColor: Color(0xFF1E5868),
               
               border: OutlineInputBorder(
               borderSide: BorderSide.none,
               borderRadius: BorderRadius.circular(15.0
               ),
               ),
               
              ),
              validator: (value) {
                if(value!.isEmpty){
                  return "email address is required";
                }
                else if(!value. contains("@")){
                return "Invalid Email address , @ is required" ;
                }
                
                return null;
              },
               
              ),

              SizedBox(
                height: 20.0,
                ),

                TextFormField(
                
                controller: passwordController,
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500,
                ),
              decoration: InputDecoration(
                suffixIcon: showIcon(),
                hintText: " Secured Password ",
                hintStyle: TextStyle(
                color: Colors.white,
                ),
                filled: true,
                fillColor: Color(0xFF1E5868),
               
               border: OutlineInputBorder(
               borderSide: BorderSide.none,
               borderRadius: BorderRadius.circular(15.0
               ),
               ),
               
              ),
            
              obscureText: showPassword ? false : true,
              validator: (value) {
                if(value!.isEmpty){
                  return "Password is required";
                }
                else if(value.length < 8){
                return "Password should be 8 characters";
                }
              
                return null;
              },
               
              ),

              SizedBox(height: 15.0,
              ),

               GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                   return Forgot();
                  }));
                },
                 child: Text("Forgot Password", style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700,fontSize: 16.0,
                 ),
                 textAlign: TextAlign.center,
                 ),
               ),

              SizedBox(height: 40.0,
              ),

              GestureDetector(
                onTap: () {
                  if (loginKey.currentState!.validate()){
                  // print("submitted Login successful");

                 signIn();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                 width: double.infinity,
                 height:50.0,
                
                 decoration: BoxDecoration(
                   color: Color(0xFF049FA3),
                   borderRadius: BorderRadius.circular(15.0
                   ),
                   ),
                   child: Text("Login",style:TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0,
                   ) ,
                   ) ,
                ),
              )
          
            ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}