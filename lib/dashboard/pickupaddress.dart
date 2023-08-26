import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pacego/provider/pickprovider.dart';
import 'dart:convert';

import 'package:provider/provider.dart';




class PickupAddress extends StatefulWidget {
  const PickupAddress({super.key});

  @override
  State<PickupAddress> createState() => _PickupAddressState();
}

class _PickupAddressState extends State<PickupAddress> {
  TextEditingController inputController = TextEditingController();
  List place = [
    "Lagos State Nigeria",
    "Aso Rock Abuja Fct",
    "Onitsha Anambra Nigeria"
  
  ];
  List predictions = [];
    

  getPrediction ( String value) async{

    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${value}&language=sp&type=geocode&components=country:es&key= AIzaSyBzt_dYPF4iZorlJAGggSXlnaCaDKMJ4S0";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      
      var res = json.decode(response.body);

      var myPrediction = res ["predictions"].toList();

      setState(() {
        predictions = myPrediction;
      });
    }
  }

  getLatLong(String place_id)async{
    
    String url_2 =
    "https://maps.googleapis.com/maps/api/geocode/json?place_id=${place_id}&key=AIzaSyBzt_dYPF4iZorlJAGggSXlnaCaDKMJ4S0";

    final response = await http.get(Uri.parse(url_2));
    if (response.statusCode == 200){
      var res = json.decode(response.body);

      double latitude = res["results"][0]["geometry"]["location"]["lat"];
      double longitude = res ["results"][0]["geometry"]["location"]["lng"];
      context.read<PickupProvider>().setLatitude(latitude);
      context.read<PickupProvider>().setLongitude(longitude);
    }

     Navigator.pop(context);

  }

    
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
                getPrediction(value);
              },
              style:TextStyle(
                  color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.w500,
                ) ,
              textAlign: TextAlign.center,
              decoration:InputDecoration(
                hintText: "Pickup Address",
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

          SizedBox(height: 30.0,
          ),
           
           Expanded(
             child: Container(
              height: 400.0,
              child: predictions.length > 0 ?
              ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      context.read<PickupProvider>().setPickupAddress(predictions[index]["description"]);

                      getLatLong(predictions[index]["place_id"]);

                      
                    },
                    title: Text(predictions[index]["description"],
                    style: TextStyle(
                      color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w500,
                    ),
                    ),
                  );
                }):
                SizedBox(height:20.0
                ),
                ),
             ),
           
        ],
      ),
    );
  }
}