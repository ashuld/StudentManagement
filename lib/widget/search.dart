import 'dart:io';

import 'package:addstudentpro/DB/funtions/funtions.dart';
import 'package:addstudentpro/widget/informationst.dart';
import 'package:addstudentpro/widget/listst.dart';
import 'package:flutter/material.dart';
import 'package:addstudentpro/DB/model/model.dart';

class SearchBarWidget extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        }, 
        icon: const Icon(Icons.clear),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
  return ValueListenableBuilder(
    valueListenable: studentlistnotifier, 
    builder: (
      BuildContext context, List<StudentModel> studentlist, Widget? child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final data = studentlist[index];
          if (data.name.toLowerCase().contains(query.toLowerCase())) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: 
                        (context) => const ListStudentWidget(),
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.photo)),
                  ),
                ),
                const Divider()
              ],
            );
          } else {
            
          }
        },  
        itemCount: studentlist.length);
    },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentlistnotifier, 
      builder: (BuildContext context, List<StudentModel> studentlist, Widget? child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final data = studentlist[index];
            if (data.name.contains(query)) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => Studentinformation(
                            name: data.name, 
                            age: data.age, 
                            number: data.mobile, 
                            place: data.place, 
                            photo: data.photo),));
                    },
                  ),
                ],
              );
            } else {
              
            }
          }, 
          itemCount: studentlist.length,
          );
      },);
  }
}