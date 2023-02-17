import 'dart:io';
import 'package:flutter/material.dart';

class Studentinformation extends StatelessWidget {
  final String name;
  final String age;
  final String number;
  final String place;
  final String photo;
  int? index;

  Studentinformation(
      {super.key,
      required this.name,
      required this.age,
      required this.number,
      required this.place,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(' Student Information')),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.5),
          child: Column(
            children: [
              const Center(),
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(File(photo)),
              ),
              const SizedBox(
                height: 25,
              ),
              Text("Name:$name",
                  style: const TextStyle(color: Colors.black, fontSize: 25)),
              const SizedBox(
                height: 25,
              ),
              Text("Age:$age",
                  style: const TextStyle(color: Colors.black, fontSize: 25)),
              const SizedBox(
                height: 25,
              ),
              Text("Mobile No.:$number",
                  style: const TextStyle(color: Colors.black, fontSize: 25)),
              const SizedBox(
                height: 25,
              ),
              Text("Place:$place",
                  style: const TextStyle(color: Colors.black, fontSize: 25)),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    ' Cancel',
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
