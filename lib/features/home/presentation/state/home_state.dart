import 'package:flutter/material.dart';

import '../../../batch/presentation/view/add_batch_view.dart';
import '../../../course/presentation/view/add_course_view.dart';
import '../view/bottom_view/dashboard_view.dart';
import '../view/bottom_view/profile_view.dart';

class HomeState{
  final int index;
  final List<Widget> listWidgets;

  HomeState({required this.index, required this.listWidgets});

  HomeState.initialState()
    : index = 0,
      listWidgets = [
        const DashboardView(),
        const AddCourseView(),
        AddBatchView(),
        const ProfileView(),
      ];

  HomeState copyWith({
    int? index,
}) {
    return HomeState(
      index: index ?? this.index,
      listWidgets: listWidgets,
    );
  }
}