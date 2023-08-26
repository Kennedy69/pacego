
import 'package:flutter/material.dart';
import 'package:pacego/dashboard/home.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Register extends StatefulWidget {
  const Register ({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController passwordController = TextEditingController(); 

   
bool showPassword = false;
bool _isChecked = false;

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
   
   signUp() async{
    
    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: emailController.text, password: passwordController.text);

      final user = FirebaseAuth.instance.currentUser;

      if(user !=null){
      await  user.updateDisplayName(usernameController.text);
      // await   user.updatePhoneNumber(phoneController.text as PhoneAuthCredential);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      
      return Home();
      }));
      }

    }

    on FirebaseAuthException catch(e) {
      if(e.code == "weak-password"){
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Password is too weak",style: TextStyle(
              color: Colors.white,fontSize: 13.0,fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          ),
          );
      }
      else if(e.code == "email-already-in-use"){
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Email Already Exist, used different mail",style: TextStyle(
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

      
      appBar: AppBar(
        backgroundColor: Color(0xFF1E4854),
        title:Text("Register",style: TextStyle(
          color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true ,
        elevation: 0.0,
      ),

      body: ListView(
        shrinkWrap: true,
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                       children: [
              TextFormField(
                controller: usernameController,
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500,
                ),
              decoration: InputDecoration(
                hintText: "Username",
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
                  return "username is required";
                }
                return null;
              },
               
              ),
            
              SizedBox(
              height:15.0,
              ),
            
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
                height: 15.0,
              ),
            
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w500,
                ),
              decoration: InputDecoration(
                hintText: " Phone Number ",
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
                  return "Phone number is required";
                }
                else if(value.length < 11){
                return "Phone number should be 11 characters";
                }
                else if(value.length > 11){
                return "phone number should not be more than 11 character";
                }
                return null;
              },
               
              ),
            
              SizedBox(
                height: 15.0,
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
              SizedBox(
                height: 15.0,
              ),
            
                      Row(
                        children: [
                          Checkbox(
              side: BorderSide(
                color:  Color(0xFF049FA3),width: 2.0,
              ),
              value: _isChecked,  onChanged: (value){
                           setState(() {
                _isChecked = ! _isChecked;
                           });
                          }),
                Text("I agree with PaceGo's",
                style: TextStyle(
                  color: Colors.white,fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                ),
                SizedBox(width: 10.0,
                ),
                Text("Terms and Conditions",style: TextStyle(
                  color:Color(0xFF049FA3), fontWeight: FontWeight.w700,
                ),
                ),
                        ],
                      ),
            
              SizedBox
              (height: 40.0,
              ),

             
            
               _isChecked ? GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()){
                  // print("submitted");
                  signUp();
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
                   child: Text("Register Now",style:TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0,
                   ) ,
                   ) ,
                ),
              )
              :Container(),
                       ],
              ),
            ),
            ),
        ],
      ),
    );
  }
}