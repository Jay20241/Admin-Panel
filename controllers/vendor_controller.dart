import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multiwebpanel/global_variables.dart';
import 'package:multiwebpanel/models/vendor_model.dart';

class VendorController {
  Future<List<Vendor>> loadVendors() async{
    try {
      //send an http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/getvendors'), 
            headers: <String,String>{
              'Content-Type': 'application/json; charset=UTF-8',
        });

        print('Response: ${response.body}');

      if(response.statusCode == 200){

        List<dynamic> data = jsonDecode(response.body);
        List<Vendor> vendors = data.map((vendor)=>Vendor.fromMap(vendor)).toList();
        return vendors;

      }else{
        //throw an exeption if the server responded with an error status code
        throw Exception('Failed to load Vendors');
      }
    } catch (e) {
      throw Exception('Error loading Vendors: $e');
    }
  }
}