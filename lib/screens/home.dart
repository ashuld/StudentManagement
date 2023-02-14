import 'package:addstudentpro/widget/addst.dart';
import 'package:addstudentpro/widget/listst.dart';
import 'package:flutter/material.dart';
import '../DB/funtions/funtions.dart';
import '../widget/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getallstudents();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Center(
          child: Text('Student Record'),
        ),
        actions: [
          IconButton(
              onPressed: () {
               showSearch(context: context, delegate: SearchBarWidget());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: const [Expanded(child: ListStudentWidget())],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const AddStudentWidget();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
