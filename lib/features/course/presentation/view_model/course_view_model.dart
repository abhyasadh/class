import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/features/course/domain/entity/course_entity.dart';
import 'package:student_management_hive_api/features/course/domain/use_case/add_course_usecase.dart';
import 'package:student_management_hive_api/features/course/presentation/state/course_state.dart';
import '../../domain/use_case/get_all_courses_usecase.dart';

final courseViewModelProvider =
StateNotifierProvider.autoDispose<CourseViewModel, CourseState>(
      (ref) => CourseViewModel(
    addCourseUseCase: ref.read(addCourseUseCaseProvider),
    getAllCourseUseCase: ref.read(getAllCoursesUseCaseProvider),
  ),
);

class CourseViewModel extends StateNotifier<CourseState> {
  final AddCourseUseCase addCourseUseCase;
  final GetAllCourseUseCase getAllCourseUseCase;

  CourseViewModel({
    required this.addCourseUseCase,
    required this.getAllCourseUseCase,
  }) : super(CourseState.initialState()){
    getAllCourses();
  }

  void addCourse(CourseEntity course) {
    state = state.copyWith(isLoading: true);
    addCourseUseCase.addCourse(course).then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (success) {
          state = state.copyWith(isLoading: false, showMessage: true);
          getAllCourses();
        },
      );
    });
  }

  void getAllCourses() {
    state = state.copyWith(isLoading: true);
    getAllCourseUseCase.getAllCourses().then((value) {
      value.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (courses) {
          state = state.copyWith(isLoading: false, courses: courses);
        },
      );
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}