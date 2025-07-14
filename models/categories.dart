//step1: create a model class for categories
//step2: serialize and deserialize code

//NOTE: First we upload images on cloudinary and get the image url and then upload the image url to MongoDB


import 'dart:convert';

class Categories {
  final String id;
  final String name;
  final String image;
  final String banner;

  Categories({required this.id, required this.name, required this.image, required this.banner});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }

  factory Categories.fromJson(Map<String, dynamic> map) {
    return Categories(
      id: map['_id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      banner: map['banner'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  //This line will not convert the data correctly
  //factory Categories.fromJson(String source) => Categories.fromMap(json.decode(source) as Map<String, dynamic>);

}