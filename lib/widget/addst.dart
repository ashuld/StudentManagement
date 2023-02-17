import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../DB/funtions/funtions.dart';
import '../DB/model/model.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final namecontroll = TextEditingController();
  final agecontroll = TextEditingController();
  final phonecontroll = TextEditingController();
  final placecontroll = TextEditingController();

  bool imageAlert = false;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _photo?.path == null
                  ? const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/image/ava3.webp'),
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(
                        File(
                          _photo!.path,
                        ),
                      ),
                      radius: 60,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        getPhoto();
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Add image'))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: namecontroll,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Name'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: agecontroll,
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Age'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phonecontroll,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Mobile No.'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: placecontroll,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Place'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: (() {
                    if (_photo != null) {
                      onbuttonclick();
                      Navigator.of(context).pop();
                    } else {
                      imageSnackbar();
                    }
                  }),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Student')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back'))
            ],
          ),
        ),
      ])),
    );
  }

  Future<void> onbuttonclick() async {
    final name = namecontroll.text.trim();
    final age = agecontroll.text.trim();
    final mobile = phonecontroll.text.trim();
    final place = placecontroll.text.trim();
    if (_photo!.path.isEmpty ||
        name.isEmpty ||
        age.isEmpty ||
        mobile.isEmpty ||
        place.isEmpty
        ) {
      return showSnackbarMessage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.indigo,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Student added',
            style: TextStyle(
              fontStyle: FontStyle.italic, 
              color: Colors.white),
          )));
    }

    final students = StudentModel(
      name: name,
      age: age,
      mobile: mobile,
      place: place,
      photo: _photo!.path,
    );

    addstudent(students);
  }

  Future<void> showSnackbarMessage() async{
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.indigo,
      content: Text('Details Required',
      style: TextStyle(
        color: Colors.white
      ),),
      ),
      );
  }

  Future<void> imageSnackbar() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.indigo,
      content: Text('Add Image',
      style: TextStyle(
        color: Colors.white
      ),
      ),
      )
      );
  }

  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(
      source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final phototemp = File(photo.path);
      setState(() {
        _photo = phototemp;
      });
    }
  }
}
