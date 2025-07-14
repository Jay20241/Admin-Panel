import 'package:flutter/material.dart';
import 'package:multiwebpanel/views/side_bar/widgets/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = '\order-screen';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Widget rowHeader(int flex, String text){
      return Expanded(
        flex: flex,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
            color: Colors.teal
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14))
          ),
        )
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Manage Orders',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    rowHeader(2, 'Product Image'),
                    rowHeader(3, 'Product Name'),
                    rowHeader(2, 'Product Price'),
                    rowHeader(2, 'Quantity'),
                    rowHeader(3, 'Buyer Name '),
                    //rowHeader(2, 'Buyer Email'),
                    rowHeader(2, 'Buyer Address'),
                    rowHeader(1, 'Status'),
                    //_rowHeader(1, 'VIEW MORE'),
                  ],
                ),
                OrderWidget(),

                OrderWidget(),

                OrderWidget(),
          ],
        ),
      ),
    );
  }
}