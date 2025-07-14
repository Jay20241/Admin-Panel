import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/category_controller.dart';
import 'package:multiwebpanel/controllers/subcategory_controller.dart';
import 'package:multiwebpanel/models/categories.dart';
import 'package:multiwebpanel/views/side_bar/widgets/sub_category_widget.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = '\subcategory-screen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {

  final SubcategoryController subcategoryController = SubcategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<List<Categories>> futureCategories;
  late String subcatName;
  Categories? selectedCategory;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  dynamic _image;
  pickImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);

    if (result!=null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text('Sub Categories', style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.7))),
                ),
            
                Divider(color: Colors.grey, thickness: 1,),
        
                FutureBuilder(
                  future: futureCategories, 
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    else if(!snapshot.hasData || snapshot.data!.isEmpty){
                      return Center(child: Text('No Category'));
                    }else{
                      return DropdownButton<Categories>(
                        value: selectedCategory,
                        hint: Text('Select Category'),
                        items: snapshot.data!.map((Categories categories){
                          return DropdownMenuItem(value: categories,child: Text(categories.name));
                        }).toList(), 
                        onChanged: (value){
                          setState(() {
                            selectedCategory = value;
                          });
                        });
                    }
                  }),
        
                  Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                      child: Center(child: _image!=null? Image.memory(_image):Text('Sub Category image'))
                    ),
                    SizedBox(width: 10),
                    
            
                    SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value){
                          subcatName = value;
                        },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          }
                          else{
                            return 'Sub-Category Name is required';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Sub Category Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
            
                    
            
                    ElevatedButton(onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        await subcategoryController.uploadSubCategory(
                          categoryId: selectedCategory!.id, 
                          categoryName: selectedCategory!.name, 
                          image: _image, 
                          subCategoryName: subcatName, 
                          context: context);
        
                          setState(() {
                            _formKey.currentState!.reset();
                            _image = null;
                          });
                        
                      }
                    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Save')),
            
                  ],
                ),
                ElevatedButton(onPressed: (){
                      pickImage();
                    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Pick Image')
                    ),
        
                Divider(color: Colors.grey, thickness: 1,),
        
                SubCategoryWidget()
        
          ],
        ),
      ),
    );
  }
}