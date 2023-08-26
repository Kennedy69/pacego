import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pacego/dashboard/getusers.dart'; 


class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {

   final createKey = GlobalKey<FormState>();
   TextEditingController firstnameController = TextEditingController();
    TextEditingController lastnameController = TextEditingController();
     TextEditingController emailController = TextEditingController();
      TextEditingController ageController = TextEditingController();

      createRandomIdUser() async{
        final db = await FirebaseFirestore.instance;

        Map<String, dynamic> data ={
          "firstname":firstnameController.text,
          "lastname":lastnameController.text,
           "email":emailController.text,
           "age":ageController.text,
        };
        await db.collection("users").add(data).then((documentSnapshot){
       
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("user added to firestore successfully",style: TextStyle(
          color: Colors.white,fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );

        setState(() {
          firstnameController.text = "";
          lastnameController.text = "";
          emailController.text = "";
          ageController.text = "";
        });
        });
      }


      // create user with meaningful unique document ID 

      createuniqueUser() async{

        final db = FirebaseFirestore.instance;
        Map<String, dynamic> data = {
          "Firstname" :firstnameController.text,
          "Lastname"  :lastnameController.text,
          "Email"     :emailController.text,
          "Age"        :ageController.text,
        };

        await db.collection("users").doc(emailController.text).set(data).then((documentSnapshot) {
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("user added to firestore successfully",style: TextStyle(
          color: Colors.white,fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );

        setState(() {
          firstnameController.text = "";
          lastnameController.text = "";
          emailController.text = "";
          ageController.text = "";
        });
        
        });

        Navigator.push(context,MaterialPageRoute(builder: (context){
        return GetUsers();
        }));
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854),
      ),
     

      body: ListView(
        shrinkWrap: true,
        children: [


          SizedBox(
            height: 20.0,
          ),

          Text("Create Firestore User",style: TextStyle(
            color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          ),

          Form(
            key: createKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
              children: [
                TextFormField(
                  controller: firstnameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter First Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "first name is required";
                    }
                    return null;

                  },
                ),

                SizedBox(height: 15.0,
                ),

                // Lastname

                TextFormField(
                  controller: lastnameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter Last Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none
                    ),
                  ),

                   validator: (value) {
                    if(value!.isEmpty){
                      return "last name is required";
                    }
                    return null;

                  },
                ),

                SizedBox(height: 15.0,),

                // email

                 TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter Email Address",
                    hintStyle: TextStyle(
                      color: Colors.grey,fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none
                    ),
                  ),

                   validator: (value) {
                    if(value!.isEmpty){
                      return "email is required";
                    }
                    else if(!value.contains("@")){
                      return "Email address not valid";
                    }

                  },
                ),
               
              //  age
              SizedBox(height: 15.0,),

               TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: ageController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter Age",
                    hintStyle: TextStyle(
                      color: Colors.grey,fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none
                    ),
                  ),

                   validator: (value) {
                    if(value!.isEmpty){
                      return "age name is required";
                    }
                    return null;

                  },
                ),

                
              SizedBox(height: 40.0,
              ),

              GestureDetector(
                onTap: () {
                  if (createKey.currentState!.validate()){

                   createuniqueUser();
                
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
                   child: Text("Create Firestore User",style:TextStyle(
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