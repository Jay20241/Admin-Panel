import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/category_controller.dart';
import 'package:multiwebpanel/models/categories.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  //A future that will hold the list of categories once loaded from API.
  late Future<List<Categories>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories, 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(child: Text('No categories found'));
        }
        else{
          final List<Categories> categories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8), 
            itemBuilder: (context,index){
              final category = categories[index];
              return Column(
                children: [
                  Image.network(category.image, width: 100, height: 100),
                  Text(category.name),
                ],
              );
            });
        }
      });
  }
}