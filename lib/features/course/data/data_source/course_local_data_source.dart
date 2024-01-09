import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/core/network/hive_service.dart';
import 'package:student_management_hive_api/features/course/data/model/course_hive_model.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';

final courseLocalDataSourceProvider = Provider.autoDispose<CourseLocalDataSource>((ref) => CourseLocalDataSource(hiveService: ref.read(hiveServiceProvider)));

class CourseLocalDataSource {
  final HiveService hiveService;

  CourseLocalDataSource({
    required this.hiveService,
  });
  // Add Course
  Future<Either<Failure, bool>> addCourse(CourseEntity course) async {
    try{
      CourseHiveModel courseHiveModel = CourseHiveModel.toHiveModel(course);
      hiveService.addCourse(courseHiveModel);
      return const Right(true);
    } catch (e){
      return(Left(Failure(error: e.toString())));
    }
  }

  // Get All Courses
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      List<CourseHiveModel> courses = await hiveService.getAllCourses();
      List<CourseEntity> list = List.generate(
          courses.length, (index) => CourseHiveModel.toEntity(courses[index]));
      return Right(list);
    } catch (e){
      return(Left(Failure(error: e.toString())));
    }
  }
}
