import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/repository/course_repository.dart';

final getAllCoursesUseCaseProvider = Provider.autoDispose<GetAllCourseUseCase>((ref) => GetAllCourseUseCase(repository: ref.read(courseRepositoryProvider)));

class GetAllCourseUseCase{
  final ICourseRepository repository;

  GetAllCourseUseCase({required this.repository});

  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    return await repository.getAllCourses();
  }
}