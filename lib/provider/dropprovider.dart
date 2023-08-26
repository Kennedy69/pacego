import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropOffProvider with ChangeNotifier{

  // recipient_name

  String recipient_name = "";

  // get recipient_name

  String get getRecipientName =>  recipient_name;

  // set recpient_name

  void setRecipientName(String name){
 recipient_name = name;
 notifyListeners();
  }

  // recipient phonenumber

  String recipient_phone = "";

  //get recipient_phone

  String get getRecipientPhone => recipient_phone;

  // set recipient_phone

  void setRecipientPhone(String phone){
    recipient_phone = phone;
    notifyListeners();
  }

  //delivery  address

  String delivery_address = "";

  // get delivery_address

  String get getDeliveryAddress => delivery_address;

  // set delivery_ address

  void setDeliveryAddress(String address ){
    delivery_address = address;
     notifyListeners();
  }

  //category

  List categoryList = [];

  // get categorylist

  List get getCategoryList => categoryList;

  //set categorylist

  // void setCategoryList(List category){
  // categoryList = category;
  // notifyListeners();
  // }

  void updateCategoryList(String item){
    if(categoryList.contains(item)){
      categoryList.remove(item);
    }

    else if (!categoryList.contains(item)){
      categoryList.add(item);
    }

    notifyListeners();
  }
    
    // empty category list

    void setCategoryList(List list) {
      categoryList = list;
      notifyListeners();
    }

  // dropofff_apartment
  

  String dropoff_apartment = "";

  // get dropoff_apartment

  String get getDropofApartment => dropoff_apartment;

  // set dropoff_apartment

  void setDropoffApartment( String apartment){
  dropoff_apartment = apartment;
  notifyListeners();
  }

  // drop_area
   
   String dropoff_area = "";
    
    //get drop_area

    String get getDropoffArea => dropoff_area;

    //set dropoff_area

    void setDropoffArea( String area){
      dropoff_area  = area;
      notifyListeners();
    }

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