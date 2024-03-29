import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final forgotKey = GlobalKey<FormState>();
   TextEditingController emailController = TextEditingController();
   forgot() async{

    try{

      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Password Reset has been sent to your email",style: TextStyle(
              color: Colors.white,fontSize: 13.0,fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          ),
          );

          Navigator.pop(context);

    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Email not registered",style: TextStyle(
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
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854),
      ),
     

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
          key: forgotKey,
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

               

              SizedBox(height: 40.0,
              ),

              GestureDetector(
                onTap: () {
                  if (forgotKey.currentState! .validate()){
                  // print("submitted Login successful");
                  forgot();
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
                   child: Text("Forgot Password",style:TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0,
                   ) ,
                   ) ,
                ),
              ),
          
            ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}