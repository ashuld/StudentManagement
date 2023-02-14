import 'package:addstudentpro/DB/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentlistnotifier = ValueNotifier([]);

final studentDbName = 'studentname';
Future<void> addstudent(StudentModel value) async {
  final studentData = await Hive.openBox<StudentModel>(studentDbName);
  final id = await studentData.add(value);
  value.id = id;
  studentlistnotifier.value.add(value);
  studentlistnotifier.notifyListeners();
}

Future<void> getallstudents() async {
  final studentData = await Hive.openBox<StudentModel>(studentDbName);
  studentlistnotifier.value.clear();
  studentlistnotifier.value.addAll(studentData.values);
  studentlistnotifier.notifyListeners();
}

Future<void> deletestudent(int index) async {
  final studentData = await Hive.openBox<StudentModel>(studentDbName);
  await studentData.deleteAt(index);
  getallstudents();
}

Future<void> editstudent(int index, StudentModel value) async {
  final studentData = await Hive.openBox<StudentModel>(studentDbName);
  studentData.putAt(index, value);
  getallstudents();
}
