import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/config/constants/api_endpoints.dart';
import 'package:student_management_hive_api/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:student_management_hive_api/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/http_service.dart';

final batchRemoteDataSourceProvider =
Provider.autoDispose<BatchRemoteDataSource>(
      (ref) => BatchRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class BatchRemoteDataSource{
  final Dio dio;

  BatchRemoteDataSource({required this.dio});

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try{
      var response = await dio.get(ApiEndpoints.getAllBatch);
      if (response.statusCode==200){
        GetAllBatchDTO getAllBatchDTO = GetAllBatchDTO.fromJson(response.data);

        List<BatchEntity> batchList = getAllBatchDTO.data
        .map((batch) => BatchAPIModel.toEntity(batch))
        .toList();

        return Right(batchList);
      } else {
        return Left (
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try{
      BatchAPIModel batchAPIModel = BatchAPIModel.fromEntity(batch);
      var response = await dio.post(ApiEndpoints.createBatch,
      data: batchAPIModel.toJson());
      if (response.statusCode==201){
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()
          )
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}