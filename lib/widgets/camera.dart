import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pollutant_inspection/widgets/button_style.dart';

class PictureForm extends StatefulWidget {
  final String labelText; // Optional label text for the picture field
  final Function(File?) onImageSelected; // Callback for base64 image
  PictureForm({Key? key, this.labelText = 'Take a picture', required this.onImageSelected})
      : super(key: key);


  @override
  _PictureFormState createState() => _PictureFormState();
}

class _PictureFormState extends State<PictureForm> {
  File? _imageFile;


  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    // final originalImage = img.decodeImage(pickedImage as Uint8List);
    // final newImage = img.copyResize(originalImage!, width: originalImage.width, height: originalImage.height);
    // img.drawString(newImage,  "textToWrite" , font: img.BitmapFont.fromFnt("arial",newImage));
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        // _imageFile = File(newImage as String);
        widget.onImageSelected(_imageFile);
      }
    });
    // final bytes = await _imageFile!.readAsBytes();
    // final imageData = base64Encode(bytes);
    // widget.onImageSelected(imageData); // Call callback with base64 data

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (widget.labelText.isNotEmpty) Text(widget.labelText),
        // if (widget.labelText.isNotEmpty) SizedBox(width: 10.0),
        // if (_imageFile != null)
        //   Container(
        //     // child: Text(
        //     //   'تصویر مستند',
        //     //   style: TextStyle(color: Colors.white),
        //     // ),
        //     // height: 300.0,
        //     height: MediaQuery.of(context).size.height * 0.5,
        //     width: MediaQuery.of(context).size.width * 0.75,
        //     margin: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10.0),
        //       image: DecorationImage(
        //         image: FileImage(_imageFile!),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // if (_imageFile != null) SizedBox(width: 100.0),
        ElevatedButton.icon(
          style: MyButtonStyle.style(context, Colors.blue),
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt),
          label: Text('عکس گرفتن'),
        ),
      ],
    );
  }
}

///TODO write on image **********************************************
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
//
// class PictureForm extends StatefulWidget {
//   final String labelText; // Optional label text for the picture field
//   final Function(File?) onImageSelected; // Callback for base64 image
//
//   PictureForm({
//     Key? key,
//     this.labelText = 'Take a picture',
//     required this.onImageSelected,
//   }) : super(key: key);
//
//   @override
//   _PictureFormState createState() => _PictureFormState();
// }
//
// class _PictureFormState extends State<PictureForm> {
//   File? _imageFile;
//
//   Future<void> _pickImage() async {
//     final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
//
//     if (pickedImage != null) {
//       // Create an image from the picked file
//       final originalImage = img.decodeImage(await File(pickedImage.path).readAsBytes());
//
//       // Draw text on the image
//       final editedImage = _drawTextOnImage(originalImage!, "Hello, World!");
//
//       // Save the edited image to a file
//       final imagePath = '${Directory.systemTemp.path}/edited_image.png';
//       final newImageFile = File(imagePath)..writeAsBytesSync(img.encodePng(editedImage));
//
//       setState(() {
//         _imageFile = newImageFile; // Store the edited image
//       });
//
//       // Call callback with the image file
//       widget.onImageSelected(_imageFile);
//     }
//   }
//
//   img.Image _drawTextOnImage(img.Image image, String text) {
//     // Create a new image based on the original size
//     var editedImage = img.Image.from(image);
//
//     // Define the text style
//     int fontSize = 40;
//     var font = img.arial14; // Using the default font from the `image` package
//
//     // Draw the text at a specified position (x, y)
//     img.drawString(editedImage, text,x: 10,y: 250,
//         color: img.ColorFloat32.rgb(255, 255, 255), font: font); // White text
//     return editedImage;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (widget.labelText.isNotEmpty) Text(widget.labelText),
//         if (widget.labelText.isNotEmpty) SizedBox(height: 10.0),
//         ElevatedButton.icon(
//           onPressed: _pickImage,
//           icon: Icon(Icons.camera_alt),
//           label: Text('عکس گرفتن'),
//         ),
//         if (_imageFile != null) SizedBox(height: 10.0),
//         // if (_imageFile != null)
//         //   Container(
//         //     height: 300.0,
//         //     width: 300.0,
//         //     decoration: BoxDecoration(
//         //       borderRadius: BorderRadius.circular(10.0),
//         //       image: DecorationImage(
//         //         image: FileImage(_imageFile!),
//         //         fit: BoxFit.cover,
//         //       ),
//         //     ),
//         //   ),
//       ],
//     );
//   }
// }
