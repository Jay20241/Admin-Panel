import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/subcategory_controller.dart';
import 'package:multiwebpanel/models/subcategory.model.dart';

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({super.key});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {

  //A future that will hold the list of categories once loaded from API.
  late Future<List<SubcategoryModel>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = SubcategoryController().loadSubCategories();
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
          return const Center(child: Text('No subcategories found'));
        }
        else{
          final List<SubcategoryModel> subcategories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: subcategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8), 
            itemBuilder: (context,index){
              final subcategory = subcategories[index];
              return Column(
                children: [
                  Image.network(subcategory.image, width: 100, height: 100),
                  Text(subcategory.subCategoryName),
                ],
              );
            });
        }
      });
  }
}