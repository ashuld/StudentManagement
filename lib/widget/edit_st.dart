import 'dart:io';
import 'package:addstudentpro/DB/funtions/funtions.dart';
import 'package:flutter/material.dart';

import '../DB/model/model.dart';

class EditStudent extends StatefulWidget {
  final String name;
  final String age;
  final String place;
  final String mobile;
  final String image;
  final int index;

  const EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.place,
    required this.mobile,
    required this.index,
    required this.image,
    required String photo,
  });

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    namecontroller = TextEditingController(text: widget.name);
    agecontroller = TextEditingController(text: widget.age);
    placecontroller = TextEditingController(text: widget.place);
    numbercontroller = TextEditingController(text: widget.mobile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Edit Student Details',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(
                        File(widget.image),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: (){}, 
                    icon: const Icon(Icons.image), 
                    label: const Text('Change Image'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 2,
                      controller: agecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your age',
                        labelText: 'Age',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Age';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLength: 10,
                      controller: numbercontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your phone number',
                        labelText: 'Number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Number';
                        } else if (value.length < 10) {
                          return 'Invalid Phone Number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: placecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Place',
                        labelText: 'Place',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Place';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              onEditSaveButton(context);
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> onEditSaveButton(ctx) async {
    final studentmodel = StudentModel(
      name: namecontroller.text,
      age: agecontroller.text,
      mobile: numbercontroller.text,
      place: placecontroller.text,
      photo: widget.image,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        backgroundColor: Colors.indigo,
        content: Text(
          'Updated',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    editstudent(widget.index, studentmodel);
  }
}
