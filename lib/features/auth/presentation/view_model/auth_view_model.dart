import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/auth_entity.dart';
import '../../domain/use_case/register_usecase.dart';
import '../../domain/use_case/upload_image_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
      (ref) => AuthViewModel(
    ref.read(registerUseCaseProvider),
    // ref.read(loginUseCaseProvider),
    ref.read(uploadImageUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUseCase _registerUseCase;
  // final LoginUseCase _loginUseCase;
  final UploadImageUseCase _uploadImageUsecase;

  AuthViewModel(
      this._registerUseCase,
      // this._loginUseCase,
      this._uploadImageUsecase,) : super(AuthState.initial());

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _uploadImageUsecase.uploadProfilePicture(file!);
    data.fold(
          (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
          (imageName) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          imageName: imageName,
        );
      },
    );
  }

  Future<void> registerStudent(AuthEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _registerUseCase.registerStudent(entity);
    state = state.copyWith(isLoading: false);
    result.fold(
          (failure) => state = state.copyWith(error: failure.error),
          (success) => state = state.copyWith(isLoading: false,),
    );

    resetMessage();
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      imageName: null,
    );
  }

  void resetMessage() {
    state = state.copyWith(
        imageName: null, error: null, isLoading: false);
  }
}