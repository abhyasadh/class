import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:student_management_hive_api/features/auth/data/repository/auth_remote_repo_impl.dart';
import 'package:student_management_hive_api/features/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) => AuthRemoteRepoImpl(ref.read(authRemoteDataSourceProvider)));

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerStudent(AuthEntity student);
  Future<Either<Failure, bool>> loginStudent(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
