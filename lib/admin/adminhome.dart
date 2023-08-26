

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pacego/admin/order_details.dart';
import 'package:pacego/customwidgets/admin_drawer.dart';
import 'package:pacego/customwidgets/drawer.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  getIcon(status){
    if(status == "pending"){
      return Icon(
        Icons.pending, 
        size: 40,
        color: Colors.amber,
        );
    }
    else if(status == "ontransit"){
      return Icon(Icons.directions_bike,
      size: 40,
      color: Colors.blue,
      );
    }
    else{
      return Icon(Icons.check_circle,
      size: 40,
      color: Colors.green,
      );
    }
  }

  updateStatusToPending(ref)async{
    await FirebaseFirestore.instance.collection("orders").doc(ref).update({
      "status" :"pending"

    }).then((DocumentSnapshot){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("Status Updated successfully",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );
     
    });
   }

   updateStatusToOntransit(ref)async{
    await FirebaseFirestore.instance.collection("orders").doc(ref).update({
      "status" :"ontransit"

    }).then((DocumentSnapshot){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("Status Updated successfully",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );
     
    });
   }

   updateStatusToDelivered(ref)async{
    await FirebaseFirestore.instance.collection("orders").doc(ref).update({
      "status" :"delivered"

    }).then((DocumentSnapshot){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("Status Updated successfully",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );
     
    });
   }
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854),
        title: Text("Amin Dashboard",style: TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),

      drawer:AdminDrawer(),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white, 
              ),
            );
          }

         else if(snapshot.hasError){
            Center(
            child: Text("${snapshot.error}",
            style: TextStyle(
              color: Colors.white,
            ),
            ),
            );
          }

          List document = snapshot.data!.docs;

           return ListView.builder(
          itemCount: document.length,
          itemBuilder: (BuildContext context, index){
            return GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return OrderDetails(
                    pickup_address: document[index]["pickup_address"],
                    delivery_address: document[index]["dropoff_address"],
                    customer_name: document[index]["customer_name"],
                    customer_phone: document[index]["customer_phone"],
                    recipient_name: document[index]["recipient_name"],
                    recipient_phone: document[index]["recipient_phone"],
                    amount: document[index]["amount"],




                  );
                }));
              },
              onLongPress: () {
                showDialog(
                  context: context, 
                  builder:(BuildContext context){

                    var ref = document[index].reference.id;
                    return AlertDialog(
                      title: Text("Update ${document[index]["orderno"]} status",
                      
                      ),
                      content: Container(
                        height: 80.0,
                        child: Text("Current Status of this order is ${document[index]["status"]}"
                        ),
                      ),

                       actions: [
                      //  TextButton(child:Text("Cancel") ,
                      //  onPressed: () {
                      //    Navigator.of(context).pop();
                      //  },
                      //  ),

                       TextButton(child:Text("Pending", style:
                        TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold
                       ),) ,
                       onPressed: () {

                     updateStatusToPending(ref);
                      
                       }

                       
                       ),

                       TextButton(child:Text("Ontransit", style:
                        TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                       ),) ,
                       onPressed: () {

                       updateStatusToOntransit(ref);
                      
                       }

                       
                       ),

                       TextButton(child:Text("Delivered", style:
                        TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                       ),) ,
                       onPressed: () {

                      updateStatusToDelivered(ref);
                      
                       }

                       
                       ),
                      ],
                    );
                  }
                  );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                     color: Color.fromARGB(233, 248, 246, 246), 
                    borderRadius: BorderRadius.circular(15.0
                    ),
              
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             "${document[index]["pickup_address"]}",style: TextStyle(
                              color: Color.fromARGB(255, 79, 79, 79), fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                             ),
                            ),
            
                             Text(
                             "${document[index]["dropoff_address"]}",
                             style: TextStyle(
                              color: Color.fromARGB(255, 79, 79, 79), fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                             ),
                            ),
            
                            Row(
                              children: [
                                Text("Orderno:${document[index]["orderno"]}",
                                style: TextStyle(
                                  color:Color.fromARGB(255, 79, 79, 79), fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                ),
                                SizedBox(width: 30.0,
                                ),
            
                                Text("Status:${document[index]["status"]}",
                                style: TextStyle(
                                  color:Color.fromARGB(255, 79, 79, 79), fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                ),
                              ],
                            ),
                  
                           
                  
                           
                          ],
                        ),
            
                        getIcon(document[index]["status"]),
            
                      ],
                    ),
                  ),
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