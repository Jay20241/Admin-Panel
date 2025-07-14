

import 'dart:convert';

import 'package:multiwebpanel/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:multiwebpanel/models/subcategory.model.dart';
import 'package:multiwebpanel/services/manage_http_response.dart';

class SubcategoryController {
  uploadSubCategory({
    required String categoryId,
    required String categoryName,
    required dynamic image,
    required String subCategoryName,
    required context
    })async{

      try{

      ///////////////////////////////////    
      ////handle the image correct format
      ///////////////////////////////////
      var uri2 = Uri.parse('$uri/api/subcategories');
      var request = http.MultipartRequest('POST', uri2);
      request.fields['categoryId'] = categoryId;
      request.fields['categoryName'] = categoryName;
      request.fields['subCategoryName'] = subCategoryName;
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: 'subcategory.png',
        ),
      );
      
      var streamedResponse = await request.send();
      var response2 = await http.Response.fromStream(streamedResponse);
      
      
     

      manageHttpResponse(response: response2, context: context, onSuccess: (){
        showSnackbar(context, 'SubCateory uploaded successfully.');
      });

    } catch (e) {
      print('Error uploading subcategory to clodinary: $e');
    }
  }


  //load the uploaded subcategories
  Future<List<SubcategoryModel>> loadSubCategories() async{
    try {
      //send an http get request to fetch categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories'), 
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

        //print('Response: ${response.body}');

      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        List<SubcategoryModel> subcategories = data.map((subcategory) => SubcategoryModel.fromJson(subcategory)).toList();
        return subcategories;
      }else{
        throw Exception('Failed to load subcategories');
        
      }
    } catch (e) {
      throw Exception('Error loading subcategories: $e');
    }
  }


}