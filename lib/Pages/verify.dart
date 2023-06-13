// ignore_for_file: slash_for_doc_comments

/**
 * On this page the user can make a photo and the app will classify it
 * if the photo shows a violation of the rules, the negative points will be shown
 * if the photo shows a good behavior, the positive points will be shown
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _detectFaces();
      }
    });
  }

  Future<void> _detectFaces() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_image != null)
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(_image!),
                fit: BoxFit.cover,
              ),
            ),
            child: const CustomPaint(),
          ),
        ElevatedButton(
          onPressed: getImage,
          child: const Text('Take Photo'),
        ),
      ],
    );
  }
}
