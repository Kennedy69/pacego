import 'package:flutter/material.dart';
import 'package:pacego/dashboard/category.dart';
import 'package:pacego/dashboard/dropoff_address.dart';
import 'package:pacego/provider/dropprovider.dart';
import 'package:provider/provider.dart';



class DropOff extends StatefulWidget {
  const DropOff({super.key});

  @override
  State<DropOff> createState() => _DropOffState();
}

class _DropOffState extends State<DropOff> {
 final dropoffKey = GlobalKey<FormState>();
  TextEditingController CustomerNameController = TextEditingController();
   TextEditingController CustomerPhoneController = TextEditingController();
    TextEditingController houseApartmentController = TextEditingController();
    TextEditingController areaController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
       backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text("Drop Off",style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0,
        ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854)
      ),

      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 20.0,
          ),

          Form(
          key:dropoffKey,
          child:Column(
            children: [
            Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xFF1E5868),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0,
                ),
                Text("Recipient's Name *Required",style: TextStyle(
                color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                ),
                ),

                Expanded(
                  child: TextFormField(
                    initialValue: context.watch<DropOffProvider>().getRecipientName,
                    onChanged: (value) {
                      context.read<DropOffProvider>().setRecipientName(value);
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      
                      hintText: "Recipient's Name",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                      ),
                      
                      disabledBorder: InputBorder.none,
                     
                      
                    ),

                    validator: (value) {
                      if(value!.isEmpty){
                      return "Recipient'name is required";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        // Recipient'phone

          Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xFF1E5868),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0,
                ),
                Text("Recipient's Phone *Required",style: TextStyle(
                color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                ),
                ),

                Expanded(
                  child: TextFormField(
                    initialValue: context.watch<DropOffProvider>().getRecipientPhone,
                    onChanged: (value) {
                      context.read<DropOffProvider>().setRecipientPhone(value);
                    },
                    keyboardType: TextInputType.phone,
                    
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      
                      hintText: "Recipient's Phone",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                      ),
                      
                      disabledBorder: InputBorder.none,
                     
                      
                    ),

                    validator: (value) {
                      if(value!.isEmpty){
                      return "Recipient'phone is required";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),   

      // pickup address

         GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
           return DropoffAddress();
            }));
          },
           child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Container(
            
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFF1E5868),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0,
                  ),
                  Text("Delivery Address *required",style: TextStyle(
                  color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                  ),
                  ),
                  SizedBox(height: 14.0,
                  ),
         
                  Expanded(
                    child: context.watch<DropOffProvider>().getDeliveryAddress.isEmpty ?

                    Text("Select Address",style: TextStyle(
                  color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                  ),
                  ):
                  Text(context.watch<DropOffProvider>().getDeliveryAddress,
                  style: TextStyle(
                  color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                  ),
                  ),
                  ),
                ],
              ),
            ),
                 ),
               ),
         ),

        //  Categories

        
         GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:(context){
            return Category();
            }));
          },
           child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Container(
            
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFF1E5868),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0,
                  ),
                  Text("Package Category *required",style: TextStyle(
                  color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                  ),
                  ),
                  SizedBox(height: 14.0,
                  ),
         
                  Expanded(
                    child:context.watch<DropOffProvider>().getCategoryList.isNotEmpty ?
                     Text( context.watch<DropOffProvider>().getCategoryList.toString(),
                     style: TextStyle(
                  color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.w500,
                  ),  
                  )
                  :

                  Text( "Select Category",
                     style: TextStyle(
                  color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                  ),  
                  ),
                 
                  ),
                ],
              ),
            ),
                 ),
               ),
         ),
         
        //  apartment 

          Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xFF1E5868),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0,
                ),
                Text("House/Apartment(Optional)",style: TextStyle(
                color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                ),
                ),

                Expanded(
                  child: TextFormField(
                    initialValue: context.watch<DropOffProvider>().getDropofApartment,

                    onChanged: (value) {
                      context.read<DropOffProvider>().setDropoffApartment(value);
                    },
                    
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      
                      hintText: "House / Apartment (Optional)",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                      ),
                      
                      disabledBorder: InputBorder.none,
                     
                      
                    ),

                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),   

      // Area

         
          Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xFF1E5868),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0,
                ),
                Text("Area",style: TextStyle(
                color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                ),
                ),

                Expanded(
                  child: TextFormField(
                    initialValue: context.watch<DropOffProvider>().getDropoffArea,

                    onChanged: (value) {
                      context.read<DropOffProvider>().setDropoffArea(value);
                    },
                    keyboardType: TextInputType.phone,
                    
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      
                      hintText: "Area(Optional)",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                      ),
                      
                      disabledBorder: InputBorder.none,
                     
                      
                    ),

                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),   

         SizedBox(height: 30.0),

       Padding(
         padding: const EdgeInsets.all(10.0),
         child: GestureDetector(
                  onTap: () {
                    
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
                     child: Text("Save Dropoff",style:TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0,
                     ) ,
                     ) ,
                  ),
                ),
       )
          ],
          ),
          ),

          // Text(context.watch<DropOffProvider>().getLatitude.toString(),style: TextStyle(
          //   color: Colors.white,fontSize: 15.0,
          // ),
          // textAlign: TextAlign.center,
          // ),

          // Text(context.watch<DropOffProvider>().getLongitude.toString(),style: TextStyle(
          //   color: Colors.white,fontSize: 15.0,
          // ),
          // textAlign: TextAlign.center,
          // ),
        ],


      ),
      
      
    );
  }
}