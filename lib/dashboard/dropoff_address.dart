import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pacego/provider/dropprovider.dart';
import 'dart:convert';

import 'package:provider/provider.dart';



class DropoffAddress extends StatefulWidget {
  const DropoffAddress({super.key});

  @override
  State<DropoffAddress> createState() => _DropoffAddressState();
}

class _DropoffAddressState extends State<DropoffAddress> {
TextEditingController inputController = TextEditingController();

  List predictions = [];
  getPredictions  (String value) async {
  String url =
   "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${value}&language=sp&type=geocode&components=country:es&key= AIzaSyBzt_dYPF4iZorlJAGggSXlnaCaDKMJ4S0";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      var myPredictions = res["predictions"].toList();
      setState(() {
        predictions = myPredictions;
      });
    }
  }
   
   getLatLong(String place_id)async{
    
    String url_two = 
    "https://maps.googleapis.com/maps/api/geocode/json?place_id=${place_id}&key=AIzaSyBzt_dYPF4iZorlJAGggSXlnaCaDKMJ4S0";

     final response = await http.get(Uri.parse(url_two));

     if(response.statusCode == 200){

      var res = json.decode(response.body);

      double latitude = res["results"][0]["geometry"]["location"]["lat"];
      double longitude = res ["results"][0]["geometry"]["location"]["lng"];

      context.read<DropOffProvider>().setLatitude(latitude);
      context.read<DropOffProvider>().setLongitude(longitude);

     }
     Navigator.pop(context);
    }
    
  
   
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text("DropOff Address",style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0,
        ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854)
      ),

      body: Column(
        children: [
          SizedBox(
            height: 30.0,

          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: inputController,
              onChanged: (value) {
                getPredictions(value);
              },
              style:TextStyle(
                  color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.w500,
                ) ,
              textAlign: TextAlign.center,
              decoration:InputDecoration(
                hintText: "DropOff Address",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 246, 216, 216),fontSize: 16.0,fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(Icons.location_on, size: 25,color: Colors.white,
                ),
                fillColor:  Color(0xFF1E5868),
                filled: true,
          
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
                ),
              ) ,
            ),
          ),

          SizedBox(height: 20.0,
          ),
          Expanded(
            child: Container(
              height: 400.0,
              child: predictions.length > 0 ?
              ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      context.read<DropOffProvider>().setDeliveryAddress(predictions[index]["description"]);
                      
                      getLatLong(predictions[index]["place_id"]);
                    },
                    title: Text(predictions[index]["description"],
                    style: TextStyle(
                        color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }):SizedBox(height: 20.0,
                ),
            )
              ),
            
        ],
      ),
    );
  }
}