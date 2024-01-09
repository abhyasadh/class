import '../../domain/entity/course_entity.dart';

class CourseState {
  final bool isLoading;
  final List<CourseEntity> courses;
  final bool showMessage;

  CourseState({
    required this.isLoading,
    required this.courses,
    required this.showMessage,
  });

  factory CourseState.initialState()=>
      CourseState(
          isLoading: false,
          courses: [],
          showMessage: false
      );


  CourseState copyWith({
    bool? isLoading,
    List<CourseEntity>? courses,
    bool? showMessage,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      showMessage: showMessage ?? this.showMessage,
    );
  }
}
