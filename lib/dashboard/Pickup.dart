import 'package:flutter/material.dart';
import 'package:pacego/dashboard/pickupaddress.dart';
import 'package:pacego/provider/pickprovider.dart';
import 'package:pacego/provider/userprovider.dart';
import 'package:provider/provider.dart';


class PickUp extends StatefulWidget {
  const PickUp({super.key});

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {
  final pickupKey = GlobalKey<FormState>();
  TextEditingController CustomerNameController = TextEditingController();
   TextEditingController CustomerPhoneController = TextEditingController();
    TextEditingController houseApartmentController = TextEditingController();
    TextEditingController areaController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
       backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text("Pickup",style: TextStyle(
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
          key: pickupKey,
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
                Text("Customer's Name *Required",style: TextStyle(
                color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                ),
                ),

                SizedBox(height: 14.0,
                  ),
         

                 Expanded(
                    child: Text(context.read<UserProvider>().getUsername,style: TextStyle(
                  color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                  ),
                  ),
                  ),
              ],
            ),
          ),
        ),
      ),
        // Customer'phone

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
                Text("Customer's Phone *Required",style: TextStyle(
                color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                ),
                ),

                Expanded(
                  child: TextFormField(
                    initialValue: "${context.watch<PickupProvider>().getPhone}",
                    onChanged: (value) {
                      context.read<PickupProvider>().setPhone(value);
                    },
                    keyboardType: TextInputType.phone,
                    
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      
                      hintText: "Customer's Phone",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                      ),
                      
                      disabledBorder: InputBorder.none,
                     
                      
                    ),

                    validator: (value) {
                      if(value!.isEmpty){
                      return "Customer'phone is required";
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
            return PickupAddress();
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
                  Text("Pickup Address *required",style: TextStyle(
                  color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w700,
                  ),
                  ),
                  SizedBox(height: 14.0,
                  ),
         
                  Expanded(
                    child:context.watch<PickupProvider>().getPickupAddress.isEmpty?
                    Text("Select Address",style: TextStyle(
                  color: Color.fromARGB(255, 253, 238, 238),fontSize: 14.0,fontWeight: FontWeight.w500,
                  ),
                  )
                  :
                   Text(context.watch<PickupProvider>().getPickupAddress,
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
                    initialValue: "${context.watch<PickupProvider>().getApartment}",
                    

                    onChanged: (value) {
                      context.read<PickupProvider>().setApartment(value);
                    },
                    
                    // controller: houseApartmentController,
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
                    initialValue: context.watch<PickupProvider>().getArea,
                    onChanged: (value) {
                      context.read<PickupProvider>().setArea(value);
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
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return PickUp();
                    }));
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
                     child: Text("Save Pickup",style:TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18.0,
                     ) ,
                     ) ,
                  ),
                ),
       )
          ],
          ),
          ),
          // Text(context.watch<PickupProvider>().getLatitude.toString(),style: TextStyle(
          //   color: Colors.white,fontSize: 15.0,
          // ),
          // textAlign: TextAlign.center,
          // ),

          // Text(context.watch<PickupProvider>().getLongitude.toString(),style: TextStyle(
          //   color: Colors.white,fontSize: 15.0,
          // ),
          // textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}