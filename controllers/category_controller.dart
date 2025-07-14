// cloudinary_public: ^0.23.1

//WE ARE USING MVC PATTERN
//NOTE: First we upload images on cloudinary and get the image url and then upload the image url to MongoDB


import 'dart:convert';

import 'package:multiwebpanel/global_variables.dart';
import 'package:multiwebpanel/models/categories.dart';
import 'package:http/http.dart' as http;
import 'package:multiwebpanel/services/manage_http_response.dart';

class CategoryController {
  uploadCategory({required dynamic pickedImage, required dynamic pickedBanner, required String name, required context}) async{
    try {
     
      ///////////////////////////////////    
      ////handle the image correct format
      ///////////////////////////////////
      var uri2 = Uri.parse('$uri/api/categories');
      var request = http.MultipartRequest('POST', uri2);
      request.fields['name'] = name;
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          pickedImage,
          filename: 'category.png',
          //contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'banner',
          pickedBanner,
          filename: 'banner.png',
          //contentType: MediaType('image', 'jpeg'),
        ),
      );
      var streamedResponse = await request.send();
      var response2 = await http.Response.fromStream(streamedResponse);
      
      manageHttpResponse(response: response2, context: context, onSuccess: (){
        showSnackbar(context, 'Cateory uploaded successfully.');
      });

    } catch (e) {
      print('Error uploading to clodinary: $e');
    }


  }

  //load the uploaded categories
  Future<List<Categories>> loadCategories() async{
    try {
      //send an http get request to fetch categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'), 
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

        print('Response: ${response.body}');

      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        List<Categories> categories = data.map((category) => Categories.fromJson(category)).toList();
        return categories;
      }else{
        throw Exception('Failed to load categories');
        
      }
    } catch (e) {
      throw Exception('Error loading categories: $e');
    }
  }

}