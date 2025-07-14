import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/order_controller.dart';
import 'package:multiwebpanel/models/order_model.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<OrderWidget> {
  
  late Future<List<OrderModel>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = OrderController().loadOrders();
  }
  
  @override
  Widget build(BuildContext context) {

    Widget buyerData(int flex, Widget widget){
      return Expanded(
        flex: flex,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Center(child: widget),
        )
      );
    }

    return FutureBuilder(
      future: futureOrders, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('No Orders'));
        }
        else{

          //this is "orders", not "buyers".
          List<OrderModel> buyers = snapshot.data!;
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: buyers.length,
                itemBuilder: (context,index){
                  final buyer = buyers[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        buyerData(2, Image.network(buyer.image, width: 50, height: 50)),
                        buyerData(3, Text(buyer.productName)),
                        buyerData(2, Text('\$${buyer.productPrice.toStringAsFixed(2)}')),
                        buyerData(2, Text(buyer.quantity.toString())),
                        buyerData(3, Text(buyer.fullName)),
                        //buyerData(2, Text(buyer.email)),
                        buyerData(2, Text('${buyer.locality}, ${buyer.city}, ${buyer.state}')),
                        buyerData(1, Row(
                          children: [
                            SizedBox(width: 5),
                            Container(width: 10, height: 10,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 2),
                            Text(buyer.delivered==true?"Delivered":buyer.processing==true?"Processing":"Canceled", 
                            style: TextStyle(fontSize: 11),),  
                          ],
                        )),
              
              
              
                      ],
                    ),
                  );
                }),
                
            ],
          );
        }
      });
  }
}