import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OrderDetails extends StatefulWidget {

  final pickup_address;
  final delivery_address;

  final customer_name;
  final customer_phone;

  final recipient_name;
  final recipient_phone;

  final amount;

  const OrderDetails({super.key,this.pickup_address, this.delivery_address, this.customer_name,
  this.customer_phone, this.recipient_name, this.recipient_phone, this.amount
  });


  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1E4854),
        title: Text("Order Details",style:TextStyle(
          color: Colors.white,
          fontSize: 18.0,

        ) ,
        ),
        centerTitle: true,
      ),

      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.location_disabled,
                  color: Colors.amber,
                  ),
                  Text("${widget.pickup_address}",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  )
                ],
              ),
            ),
          ),

          // delivery address

           Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.location_city,
                  color: Colors.green,
                  ),
                  Text("${widget.delivery_address}",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  )
                ],
              ),
            ),
          ),

          // customer name
           Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.person,
                  color: Colors.amber,
                  ),
                  Text("${widget.customer_name}",style:
                  GoogleFonts.lusitana(
                    color: Colors.black,
                    fontSize: 15.0,

                  ),
                  )
                ],
              ),
            ),
          ),
          
          // customer phone

          
           Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.phone,
                  color: Colors.amber,
                  ),
                  Text("${widget.customer_phone}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15.0,

                  ),
                  )
                ],
              ),
            ),
          ),

          // recipient name

          
           Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.phone,
                  color: Colors.green,
                  ),
                  Text("${widget.recipient_name}",style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  )
                ],
              ),
            ),
          ),

          // recipient phone

          
           Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.phone,
                  color: Colors.green,
                  ),
                  Text("${widget.recipient_phone}",style:
                   GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 15.0,

                   ),
                  )
                ],
              ),
            ),
          ),

          //  amount

          
           Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50.0,
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.money,
                  color: Colors.green,
                  ),
                  Text("${widget.amount}",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }
}