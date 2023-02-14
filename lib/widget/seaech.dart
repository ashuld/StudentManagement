import 'dart:io';
import 'package:addstudentpro/DB/funtions/funtions.dart';
import 'package:addstudentpro/widget/informationst.dart';
import 'package:addstudentpro/widget/listst.dart';
import 'package:flutter/material.dart';
import '../DB/model/model.dart';

class SearchWidget extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentlistnotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final data = studentlist[index];
              if (data.name.toLowerCase().contains(query.toLowerCase())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ListStudentWidget();
                          },
                        ));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return Container(
                  
                );
              }
            },
            itemCount: studentlist.length,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentlistnotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              final data = studentlist[index];
              if (data.name.contains(query)) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Studentinformation(
                                name: data.name,
                                age: data.age,
                                number: data.mobile,
                                place: data.place,
                                photo: data.photo);
                          },
                        ));
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                          backgroundImage: FileImage(File(data.photo))),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return
                const Center(child: Text(''));
              }
            }),
            itemCount: studentlist.length,
          );
        });
  }
}
