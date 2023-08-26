import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GetUsers extends StatefulWidget {
  const GetUsers({super.key});

  @override
  State<GetUsers> createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {
  final updateKey = GlobalKey<FormState>();
  String firstname = "";
  String lastname = "";
  String email = "";
  String age = "";

  updateUser(f,l,e,a)async {

    await FirebaseFirestore.instance.collection("users").doc(e).update({
      "Firstname":f,
       "Lirstname":l,
        "Email":e,
         "Age":a,
    }).then((documentSnapshot){

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("user Updated successfully",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return GetUsers();
        }));
    });

  }

  deleteUser(email )async{
    await FirebaseFirestore.instance.collection("users").doc(email).delete();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("user Updated successfully",style: TextStyle(
          color: Colors.white,fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return GetUsers();
        }));


  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E4854),
        elevation: 0.0,
        title: Text("All Firestore Users",style: TextStyle(
          color: Colors.white,fontSize: 17.0, fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),
      body:FutureBuilder(
        future: FirebaseFirestore.instance.collection("users"). orderBy("Email")  . get(),
        builder:(BuildContext context, snapshot){

          // check if the collection state  is waiting

          // check if there is an error

          // return what you want i.e listviewbuilder

          if(snapshot.connectionState == ConnectionState.waiting){

            return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: 
            Text(" An Error occured ",style: TextStyle(
              color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold,
            ),
            )
            );
          }

          
          List document = snapshot.data!.docs;

          return ListView.builder(
            itemCount: document.length,
            itemBuilder: (BuildContext context ,index){
              return ListTile(
                onLongPress:() {
                  showDialog(context: context, 
                  builder:( BuildContext context){
                    return AlertDialog(
                      title: Text("Remove ${document[index]["Firstname"]} details"),

                      content: Container(
                        height: 60.0,
                        child: Text("Kindly note that the deleted data cannot be retrieved",style: TextStyle(
                          color: Colors.red,fontSize: 14.0,
                        ),
                        ),
                      ),

                      actions: [
                       TextButton(child:Text("Cancel") ,
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                       ),

                       TextButton(child:Text("Delete", style: TextStyle(
                        color: Colors.red,fontWeight: FontWeight.bold
                       ),) ,
                       onPressed: () {

                 
                      //  your delete function here
                       

                        deleteUser(document[index]["Email"]);
                       }

                       
                       ),
                      ],


                    );
                  });
                },
                leading:Icon(Icons.person,color: Colors.white,
                ),
                
                title: Text("${document[index]["Email"]}",style: TextStyle(
                  color: Colors.white,
                ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(context: context,
                     builder: (BuildContext context){
                     return AlertDialog(
                      title: Text("Edit ${document[index]["Firstname"]} details"),

                      content: Container(
                        height:250.0 ,
                        child: Form(
                          key: updateKey,
                          child:
                         Column(
                          children: [
                            TextFormField(
                           
                           initialValue: document[index]["Firstname"],
                           decoration: InputDecoration(


                           ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Firstname is required";
                              }
                              return null;
                              
                            },
                            onSaved: (value) {
                              setState(() {
                                firstname = value!;
                              });
                            },
                            ),

                            SizedBox(
                              height: 5.0,
                            ),

                            // Lastname

                            TextFormField(
                           
                           initialValue: document[index]["Lastname"],
                           decoration: InputDecoration(


                           ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Lastname is required";
                              }
                              return null;
                              
                            },
                            onSaved: (value) {
                              setState(() {
                                lastname = value!;
                              });
                            },
                            ),

                            // Email

                            SizedBox(
                              height: 5.0,
                            ),

                            // Lastname

                            TextFormField(
                              enabled: false,
                              keyboardType: TextInputType.emailAddress,
                           
                           initialValue: document[index]["Email"],
                           decoration: InputDecoration(


                           ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Email field is required";
                              }
                              return null;
                              
                            },
                            onSaved: (value) {
                              setState(() {
                                email = value!;
                              });
                            },
                            ),

                            SizedBox(
                              height: 5.0,
                            ),

                            // Lastname

                            TextFormField(
                              keyboardType: TextInputType.number,
                           
                           initialValue: document[index]["Age"],
                           decoration: InputDecoration(


                           ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return "Age is required";
                              }
                              return null;
                              
                            },
                            onSaved: (value) {
                              setState(() {
                                age = value!;
                              });
                            },
                            ),
                          ],
                         ),
                         ),
                      ),
                      actions: [
                       TextButton(child:Text("Cancel") ,
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                       ),

                       TextButton(child:Text("Update") ,
                       onPressed: () {


                        // check if the form is valid
                       if (updateKey.currentState!.validate()){
                        updateKey.currentState!.save();

                        updateUser(firstname, lastname, email, age);
                       }

                        // save the data
                        //  call update function
                       },
                       ),
                      ],
                     );
                     }
                     );
                  },
                  child: Icon(Icons.edit, color: Colors.white,
                  ),
                ),
              );
            }
            );
           
        }
        ),

    );
  }
}