import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureForm extends StatefulWidget {
  final String labelText; // Optional label text for the picture field
  final Function(File?) onImageSelected; // Callback for base64 image
  PictureForm({Key? key, this.labelText = 'Take a picture',required this.onImageSelected}) : super(key: key);
  @override
  _PictureFormState createState() => _PictureFormState();
}

class _PictureFormState extends State<PictureForm> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
    // final bytes = await _imageFile!.readAsBytes();
    // final imageData = base64Encode(bytes);
    // widget.onImageSelected(imageData); // Call callback with base64 data
    widget.onImageSelected(_imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.labelText.isNotEmpty) Text(widget.labelText),
        if (widget.labelText.isNotEmpty) SizedBox(width: 10.0),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt),
          label: Text('عکس گرفتن'),
        ),
        if (_imageFile != null)
          SizedBox(width: 10.0),
        // if (_imageFile != null)
        //   Container(
        //     height: 300.0,
        //     width: 300.0,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10.0),
        //       image: DecorationImage(
        //         image: FileImage(_imageFile!),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}


