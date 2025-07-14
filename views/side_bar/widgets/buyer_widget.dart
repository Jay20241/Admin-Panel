import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/buyer_controller.dart';
import 'package:multiwebpanel/models/buyer_model.dart';

class BuyerWidget extends StatefulWidget {
  const BuyerWidget({super.key});

  @override
  State<BuyerWidget> createState() => _BuyerWidgetState();
}

class _BuyerWidgetState extends State<BuyerWidget> {
  
  late Future<List<BuyerModel>> futureBuyers;

  @override
  void initState() {
    super.initState();
    futureBuyers = BuyerController().loadBuyers();
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
      future: futureBuyers, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('No banners found'));
        }
        else{
          List<BuyerModel> buyers = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: buyers.length,
            itemBuilder: (context,index){
              final buyer = buyers[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    buyerData(1, CircleAvatar(child: Text(buyer.fullname[0].toUpperCase()))),
                    buyerData(3, Text(buyer.fullname)),
                    buyerData(2, Text(buyer.email)),
                    buyerData(2, Text('${buyer.locality}, ${buyer.city}, ${buyer.state}')),
                    buyerData(1, TextButton(onPressed: (){}, child: Text('Delete')))
                
                  ],
                ),
              );
            });
        }
      });
  }
}