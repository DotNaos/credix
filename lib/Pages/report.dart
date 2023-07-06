// ignore_for_file: slash_for_doc_comments

/**
 * On this page the user can make a photo and the app will classify it
 * if the photo shows a violation of the rules, the negative points will be shown
 * if the photo shows a good behavior, the positive points will be shown
 */

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/user_data.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  File? _image;
  final picker = ImagePicker();
  String? _selectedUser;
  int? pointsToRemove;
  String? description;

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Take a photo or select a photo from the gallery
            if (_image != null)
              GestureDetector(
                onTap: getImage,
                child: Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const CustomPaint(),
                ),
              ),
            if (_image == null)
              Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton.filled(
                  onPressed: getImage,
                  icon: const Icon(Icons.camera_alt),
                  padding: const EdgeInsets.all(30),
                  style: ElevatedButton.styleFrom(),
                ),
              ),

            const SizedBox(height: 20),

            // Row to select a user and how many points should be removed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // show a dropdown of all users to select a user a photo should be taken of
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return DropdownMenu<String>(
                          hintText: 'Select User',
                          onSelected: (String? newValue) {
                            setState(() {
                              _selectedUser = newValue;
                            });
                          },
                          dropdownMenuEntries: snapshot.data!.docs.map(
                            (user) {
                              return DropdownMenuEntry<String>(
                                value: user.id,
                                label: user.get('name').toString().isEmpty
                                    ? user.get('email')
                                    : user.get('name'),
                              );
                            },
                          ).toList(),
                        );
                      }
                      return const CircularProgressIndicator();
                    }),

                // Input field to enter the points to remove
                // Only numbers are allowed
                SizedBox(
                  width: 100,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        pointsToRemove = int.parse(value);
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Points',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Multiline Textfield to enter a description of the violation
            Container(
              child: TextField(
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Description',
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // upload image to firebase storage
                // create a new folder for this user
                // upload the image to this folder

                // Get the data from the form and submit it to the database
                if (_selectedUser == null || pointsToRemove == null) {
                  ScaffoldMessenger.of(context).clearSnackBars();

                  // Show an error message if the user or the points are not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a user and points'),
                    ),
                  );
                  return;
                }
                var user = FirebaseFirestore.instance
                    .collection('users')
                    .doc(_selectedUser);
                if (pointsToRemove! < 0) {
                  // Display a warning message if the user wants to remove positive points
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a positive number'),
                    ),
                  );
                } else {
                  UserData().addReport(
                      _selectedUser!, pointsToRemove!, description, _image);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
