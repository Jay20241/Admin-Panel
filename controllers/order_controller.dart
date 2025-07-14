import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multiwebpanel/global_variables.dart';
import 'package:multiwebpanel/models/order_model.dart';

class OrderController {
  Future<List<OrderModel>> loadOrders() async{
    try {
      //send an http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders'), 
            headers: <String,String>{
              'Content-Type': 'application/json; charset=UTF-8',
        });

        //print('Response: ${response.body}');

      if(response.statusCode == 200){

        List<dynamic> data = jsonDecode(response.body);
        List<OrderModel> orders = data.map((order)=>OrderModel.fromJson(order)).toList();
        return orders;

      }else{
        //throw an exeption if the server responded with an error status code
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error loading orders: $e');
    }
  }
}