import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String mobile;
  @HiveField(4)
  final String place;
  @HiveField(5)
  final String photo;

  StudentModel(
      {required this.name,
      required this.age,
      required this.mobile,
      required this.place,
      required this.photo,
      this.id});
}
