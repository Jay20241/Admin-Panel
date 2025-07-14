import 'package:flutter/material.dart';
import 'package:multiwebpanel/views/side_bar/widgets/vendor_widget.dart';

class VendorsScreen extends StatelessWidget {

  static const String id = '\vendor-screen';
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Widget rowHeader(int flex, String text){
      return Expanded(
        flex: flex,
        child: Container(
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
                        'Manage Vendors',
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
                    rowHeader(1, 'Image'),
                    rowHeader(3, 'Full Name '),
                    rowHeader(2, 'Email'),
                    rowHeader(2, 'Address'),
                    rowHeader(1, 'Delete'),
                    //_rowHeader(1, 'VIEW MORE'),
                  ],
                ),
                VendorWidget()
          ],
        ),
      ),
    );
  }
}