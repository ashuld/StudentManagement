import 'dart:io';
import 'package:addstudentpro/widget/edit_st.dart';
import 'package:addstudentpro/widget/informationst.dart';
import 'package:flutter/material.dart';
import '../DB/funtions/funtions.dart';
import '../DB/model/model.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentlistnotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final data = studentlist[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(
                    File(data.photo),
                  ),
                ),
                title: Text(data.name),
                trailing: Wrap(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EditStudent(
                                name: data.name,
                                age: data.age,
                                place: data.place,
                                mobile: data.mobile,
                                index: index,
                                image: data.photo,
                                photo: '');
                          },
                        ));
                      },
                      icon: const Icon(Icons.edit),
                      ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text('Delete This Student ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        deletestudent(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              );
                            }));
                      },
                      icon: const Icon(Icons.delete))
                ]),
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
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black,
              );
            },
            itemCount: studentlist.length);
      },
    );
  }
}
