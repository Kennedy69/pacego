import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pacego/dashboard/Pickup.dart';
import 'package:pacego/dashboard/createuser.dart';
import 'package:pacego/dashboard/dropoff.dart';
import 'package:pacego/dashboard/orders.dart';
import 'package:pacego/provider/dropprovider.dart';
import 'package:pacego/provider/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:pacego/provider/pickprovider.dart';
import 'dart:math' as Math;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';




class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {

  bool isLoading = false;
  String selectedType = "Same day";
  String paymemtMethod = "cash";


  //earth radius
  final double earthRadius = 6371.0;

//convert degree to radian
  double _degreesToRadians(double degrees) {
    return degrees * Math.pi / 180;
  }

  double distanceInKmBetweenEarthCoordinates(
      double lat1, double lon1, double lat2, double lon2) {
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = Math.pow(Math.sin(dLat / 2), 2) +
        Math.cos(_degreesToRadians(lat1)) *
            Math.cos(_degreesToRadians(lat2)) *
            Math.pow(Math.sin(dLon / 2), 2);

    final double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return earthRadius * c;
  }

  int generateRandom(){
    Random random = Random();
    int min = 100000;
    int max = 999999;
    return min + random.nextInt(max-min);


  }

  addOrderToFirestore()async{
    setState(() {
      isLoading = true;
    });

    final db =  FirebaseFirestore.instance;

        Map<String, dynamic> data ={
          "customer_name":context.read<UserProvider>().getUsername,
          "customer_phone":context.read<PickupProvider>().getPhone,
          "distance":      distanceInKmBetweenEarthCoordinates(
              context.read<PickupProvider>().getLatitude,
             context.read<PickupProvider>().getLongitude,
             context.read<DropOffProvider>().getLatitude,
             context.read<DropOffProvider>().getLongitude) .toInt(),
          "dropoff_address" :context.read<DropOffProvider>().getDeliveryAddress,
          "dropoff_lat"     :context.read<DropOffProvider>().getLatitude,
           "dropoff_long"   :context.read<DropOffProvider>().getLongitude,
           "orderno"        : generateRandom(),
           "pickup_address" :context.read<PickupProvider>().getPickupAddress,
           "pickup_area"    :context.read<PickupProvider>().getArea,
           "pickup_house"   :context.read<PickupProvider>().getApartment,
           "pickup_lat"     :context.read<PickupProvider>().getLatitude,
           "pickup_long"    :context.read<PickupProvider>().getLongitude,
           "recipient_house":context.read<DropOffProvider>().getDropofApartment,
           "recipient_name" :context.read<DropOffProvider>().getRecipientName,
           "recipient_phone":context.read<DropOffProvider>().getRecipientPhone,
           "status"         :"pending",
           "customer_email" :context.read<UserProvider>().getEmail,
           "category"       :context.read<DropOffProvider>().getCategoryList.toString(),
           "amount"         :"N ${distanceInKmBetweenEarthCoordinates(
              context.read<PickupProvider>().getLatitude,
             context.read<PickupProvider>().getLongitude,
             context.read<DropOffProvider>().getLatitude,
             context.read<DropOffProvider>().getLongitude) .toInt() *300}"

  };

  await db.collection("orders").
  doc(generateRandom().
  toString()).set(data).then((documentSnapshot){

    setState(() {
      isLoading = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
        Text("Pickup order request was successful",style: TextStyle(
          color: Colors.white,fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
        ),
        );


        context.read<PickupProvider>().setPhone("");
        context.read<PickupProvider>().setLatitude(0.0);
        context.read<PickupProvider>().setLongitude(0.0);
        context.read<DropOffProvider>().setLatitude(0.0);
        context.read<DropOffProvider>().setLongitude(0.0);
        context.read<DropOffProvider>().setDeliveryAddress("");
        context.read<PickupProvider>().setPickupAddress("");
        context.read<PickupProvider>().setArea(""); 
        context.read<PickupProvider>().setApartment("");
        context.read<DropOffProvider>().setRecipientName("");
        context.read<DropOffProvider>().setRecipientPhone("");
        context.read<DropOffProvider>().setDropoffApartment("");
        context.read<DropOffProvider>().setCategoryList([]);


        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return Orders();
        }));
  } );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text("New Order",style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0,
        ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854)
      ),

    body:isLoading ? Center(child: CircularProgressIndicator(
      color: Colors.white,
    ),)
     :ListView(
      shrinkWrap: true,
      children: [
      SizedBox(height: 25.0,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(context){
           return PickUp();
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFF1E5868),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pickup",style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.w700,fontSize: 17.0,
                      ),
                      ),
                      Text("Enter Pickup details", style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14.0,
                      ),),
                    ],
                  ),
                  Icon(Icons.arrow_forward,color: Colors.white, size: 25.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

       SizedBox(height: 25.0,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context){
         return  DropOff();
          }));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFF1E5868),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Delivery Point",style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.w700,fontSize: 17.0,
                      ),
                      ),
                      Text("Enter delivery details", style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14.0,
                      ),),
                    ],
                  ),
                  Icon(Icons.arrow_forward,color: Colors.white, size: 25.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      SizedBox(height: 20.0,),

      Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Text("Deliver Type",style: TextStyle(
          color: Colors.white,fontSize: 17.0,fontWeight: FontWeight.bold,
        ),),
      ),

      Row(
        children: [
          Radio(
            activeColor: Colors.amber,
            value: "Same day", groupValue: selectedType, onChanged:(value){
           setState(() {
             selectedType = value!;
           });
           print(selectedType);
          }),
          SizedBox(width: 20.0,),
          Text("PaceGo jet (Same day delivery)",style: TextStyle(
            color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,
          ),),
        ],
      ),

      SizedBox(height: 10.0,),

       Row(
        children: [
          Radio(
            activeColor: Colors.amber,
            value: "Standard", groupValue: selectedType, onChanged:(value){
           setState(() {
             selectedType = value!;
           });
            print(selectedType);
          }),
          SizedBox(width: 20.0,),
          Text("Standard Delivery (24hours)",style: TextStyle(
            color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,
          ),),
        ],
      ),

      SizedBox(height: 10.0,),

      Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Text("Payment Method",style: TextStyle(
          color: Colors.white,fontSize: 17.0,fontWeight: FontWeight.bold,
        ),),
      ),

        Row(
        children: [
          Radio(
            activeColor: Colors.amber,
            value: "Cash", groupValue: paymemtMethod, onChanged:(value){
           setState(() {
            paymemtMethod = value!;
           });
            print(paymemtMethod);
          }),
          SizedBox(width: 20.0,),
          Text("Cash",style: TextStyle(
            color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,
          ),),
        ],
      ),
      SizedBox(height: 30.0),


      context.watch<PickupProvider>().getPhone !=""&&
       context.watch<PickupProvider>().getPickupAddress != ""&& 
       context.watch<PickupProvider>().getLatitude != 0.0 &&
        context.watch<PickupProvider>().getLongitude != 0.0 &&
        context.watch<DropOffProvider>().getRecipientName != ""&&
        context.watch<DropOffProvider>().getRecipientPhone!= ""&&
        context.watch<DropOffProvider>().getDeliveryAddress!= ""&&
        // ignore: unrelated_type_equality_checks
        context.watch<DropOffProvider>().getCategoryList.isNotEmpty &&
        context.watch<DropOffProvider>().getLatitude!= 0.0 &&
        context.watch<DropOffProvider>().getLongitude!= 0.0 
        ? Column(
          
          
     children: [

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Estimated Distance", style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0,
            ),),
      
             Text("${distanceInKmBetweenEarthCoordinates(
              context.watch<PickupProvider>().getLatitude,
             context.watch<PickupProvider>().getLongitude,
             context.watch<DropOffProvider>().getLatitude,
             context.watch<DropOffProvider>().getLongitude) .toInt()} km", style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0,
            ),)
      
        ],),
      ),


       Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount", style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0,
            ),),
      
             Text("N ${distanceInKmBetweenEarthCoordinates(
              context.watch<PickupProvider>().getLatitude,
             context.watch<PickupProvider>().getLongitude,
             context.watch<DropOffProvider>().getLatitude,
             context.watch<DropOffProvider>().getLongitude) .toInt() *300}", style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0,
            ),)
      
        ],),
      ),


       Padding(
         padding: const EdgeInsets.all(10.0),
       
                  child: GestureDetector(
                    // add to firestore
                    onTap: () {
                      addOrderToFirestore();
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
                       child: Text("Request Pickup",style:TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0,
                       ) ,
                       ) ,
                    ),
                  ),
                
                 ),

     ],
      ):
       Container(),

      

                 SizedBox(height: 20.0,
                 ),

                //  GestureDetector(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context){
                //     return CreateUser();
                //     }));
                //   },
                //    child: Text("Create Firestore Users",style: TextStyle(
                //     color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.0,
                //    ),
                //    textAlign: TextAlign.center,
                //    ),
                //  )
               
              //  SizedBox(height: 20.0,
              //  ),

              //  Text(context.read<PickupProvider>().getArea.toString(), style: TextStyle(
              //   color: Colors.white,fontSize: 20.0,
              //  ),
              //  textAlign: TextAlign.center,
              //  ),



      ],
    ),
    
     
    );
  }
}