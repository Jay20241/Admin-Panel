// cloudinary_public: ^0.23.1

//WE ARE USING MVC PATTERN
//NOTE: First we upload images on cloudinary and get the image url and then upload the image url to MongoDB


import 'dart:convert';

import 'package:multiwebpanel/global_variables.dart';
import 'package:multiwebpanel/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:multiwebpanel/services/manage_http_response.dart';

class BannerController {
  uploadBannertoCloud({required dynamic pickedImage, required context}) async{
    try {
      
      ///////////////////////////////////    
      ////handle the image correct format
      ///////////////////////////////////
      
      var uri3 = Uri.parse('$uri/api/banner');
      var request = http.MultipartRequest('POST', uri3);
      request.files.add(
        http.MultipartFile.fromBytes(
          'banner',
          pickedImage,
          filename: 'banner.png',
          //contentType: MediaType('image', 'jpeg'),
        ),
      );
      var streamedResponse = await request.send();
      var response2 = await http.Response.fromStream(streamedResponse);

      manageHttpResponse(response: response2, context: context, onSuccess: (){
        showSnackbar(context, 'Banner uploaded successfully.');
      }); 

    } catch (e) {
      print('Error uploading banner to clodinary: $e');
    }
  }

  //fetch banners:
  Future<List<BannerModel>> loadBanners() async{
    try {
      //send an http get request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'), 
            headers: <String,String>{
              'Content-Type': 'application/json; charset=UTF-8',
        });

        print('Response: ${response.body}');

      if(response.statusCode == 200){

        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners = data.map((banner)=>BannerModel.fromJson(banner)).toList();
        return banners;

      }else{
        //throw an exeption if the server responded with an error status code
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Error loading banners: $e');
    }
  }


}





 //1: make instance of cloudinary
      /*final cloudinary = CloudinaryPublic("ds3ish2ui", "upload_preset", cache: false);

      //2: upload image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(CloudinaryFile.fromBytesData(pickedImage, identifier: 'pickedImage', folder: 'banners'));
      String imageUrl = imageResponse.secureUrl;*/