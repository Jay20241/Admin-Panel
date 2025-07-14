import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:multiwebpanel/controllers/banner_controller.dart';
import 'package:multiwebpanel/views/side_bar/widgets/banner_widget.dart';

class UploadBanner extends StatefulWidget {
  static const String id = '\banner-screen';
  const UploadBanner({super.key});

  @override
  State<UploadBanner> createState() => _UploadBannerState();
}

class _UploadBannerState extends State<UploadBanner> {

  final BannerController _bannerController = BannerController();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text('Upload Banner', style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.7))),
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
            ElevatedButton(onPressed: () async{
                await _bannerController.uploadBannertoCloud(pickedImage: _image, context: context);
              }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Save')
            ),
          ],
        ),

        SizedBox(height: 10),

        ElevatedButton(onPressed: () async{
                pickImage();
              }, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('Pick Banner')
            ),

        Divider(color: Colors.grey, thickness: 1,),

        BannerWidget(),
      ],

    );
  }
}