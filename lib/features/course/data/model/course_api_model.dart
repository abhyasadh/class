import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/course_entity.dart';

@JsonSerializable()
class CourseAPIModel{
  @JsonKey(name: '_id')
  final String? courseId;
  final String courseName;

  CourseAPIModel({this.courseId, required this.courseName});

  factory CourseAPIModel.fromJson(Map<String, dynamic> json) {
    return CourseAPIModel(
      courseId: json['_id'],
      courseName: json['courseName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
    };
  }

  // From entity to model
  factory CourseAPIModel.fromEntity(CourseEntity entity) {
    return CourseAPIModel(
      courseName: entity.courseName,
    );
  }

  // From model to entity
  static CourseEntity toEntity(CourseAPIModel model) {
    return CourseEntity(
      courseId: model.courseId,
      courseName: model.courseName,
    );
  }
}