import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multiwebpanel/controllers/category_controller.dart';
import 'package:multiwebpanel/views/side_bar/widgets/category_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();
  late String categoryName;
  dynamic _image;
  dynamic _banner;
  pickImage() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);

    if (result!=null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }
  pickBanner() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);

    if (result!=null) {
      setState(() {
        _banner = result.files.first.bytes;
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
                child: Text('Categories', style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.7))),
            ),
        
            Divider(color: Colors.grey, thickness: 1,),
        
            Row(
              children: [
                SizedBox(width: 10),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(child: _image!=null? Image.memory(_image):Text('Image'))
                ),
                SizedBox(width: 10),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: Center(child: _banner!=null? Image.memory(_banner):Text('Banner'))
                ),
        
                SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value){
                      categoryName = value;
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      }
                      else{
                        return 'Category Name is required';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Category Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
        
                TextButton(onPressed: (){}, child: Text('cancel')),
        
                ElevatedButton(onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    await _categoryController.uploadCategory(pickedImage: _image, pickedBanner: _banner, name: categoryName, context: context);
                    //print('Category Name: $categoryName');
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Save')),
        
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: (){
                    pickImage();
                  }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Pick Image')
                  ),
        
                  SizedBox(width: 20),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: (){
                    pickBanner();
                  }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Pick Banner')
                  ),
        
                ],
              ),
            ),
        
            Divider(color: Colors.grey, thickness: 1,),
        
            CategoryWidget(),
            
            
          ],
        ),
      ),
    );
  }
}