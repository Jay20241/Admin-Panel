import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/vendor_controller.dart';
import 'package:multiwebpanel/models/vendor_model.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<VendorWidget> {
  
  late Future<List<Vendor>> futureVendors;

  @override
  void initState() {
    super.initState();
    futureVendors = VendorController().loadVendors();
  }
  
  @override
  Widget build(BuildContext context) {

    Widget buyerData(int flex, Widget widget){
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget
          ),
        )
      );
    }

    return FutureBuilder(
      future: futureVendors, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('No banners found'));
        }
        else{
          List<Vendor> vendors = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: vendors.length,
            itemBuilder: (context,index){
              final vendor = vendors[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    buyerData(1, CircleAvatar(child: Text(vendor.fullname[0].toUpperCase()))),
                    buyerData(3, Text(vendor.fullname)),
                    buyerData(2, Text(vendor.email)),
                    buyerData(2, Text('${vendor.locality}, ${vendor.city}, ${vendor.state}')),
                    buyerData(1, TextButton(onPressed: (){}, child: Text('Delete')))
                
                  ],
                ),
              );
            });
        }
      });
  }
}