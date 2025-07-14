import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multiwebpanel/global_variables.dart';
import 'package:multiwebpanel/models/buyer_model.dart';

class BuyerController {
  Future<List<BuyerModel>> loadBuyers() async{
    try {
      //send an http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/users'), 
            headers: <String,String>{
              'Content-Type': 'application/json; charset=UTF-8',
        });

        print('Response: ${response.body}');

      if(response.statusCode == 200){

        List<dynamic> data = jsonDecode(response.body);
        List<BuyerModel> buyers = data.map((buyer)=>BuyerModel.fromMap(buyer)).toList();
        return buyers;

      }else{
        //throw an exeption if the server responded with an error status code
        throw Exception('Failed to load Buyers');
      }
    } catch (e) {
      throw Exception('Error loading Buyers: $e');
    }
  }
}