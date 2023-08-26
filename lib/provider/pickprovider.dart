import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupProvider with ChangeNotifier{

  // phone number

  String phonenumber = "";

  // get phone number

  String get getPhone => phonenumber;

  // set phonenumber

  void setPhone(String phone) {
    phonenumber = phone;
  notifyListeners();
  }

  // 

  String pickupaddress = "";
  // get pickup address

  String get getPickupAddress => pickupaddress;
  
  //set pickup address

  void setPickupAddress(String address){
    pickupaddress =address;

    notifyListeners();
  }
  
  
  //apartment / house

  String apartment = "";

  // get appartment

  String get getApartment => apartment;
   

  //set apartment

  void setApartment(String apart){
  apartment = apart;
    notifyListeners();

  }

  // area

  String area = "";

  //get area

  String get getArea => area;

  //set area
  void setArea(String a){
    area = a;
    notifyListeners();
  }

  // latitude


  double latitude = 0.0;

  // get latitude

  double get getLatitude => latitude;

  // setlatitude

  void setLatitude(double lat){
    latitude = lat;
    notifyListeners();
  }

  // longitude

  double longitude = 0.0;

  // get longtude

  double get getLongitude => longitude;

  // set Longitude

  void setLongitude(double long){
    longitude = long;
    notifyListeners();
  }


}