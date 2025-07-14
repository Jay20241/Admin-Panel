import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/banner_controller.dart';
import 'package:multiwebpanel/models/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  //A future that will hold the list of banners once loaded from api
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('No banners found'));
        }
        else{
          List<BannerModel> banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, crossAxisSpacing: 10, mainAxisSpacing: 10), 
            itemBuilder: (context,index){
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(width: 100, height: 100, banner.image),
              );
            });
        }
      });
  }
}