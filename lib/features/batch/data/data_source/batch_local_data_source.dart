import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/core/network/hive_service.dart';
import 'package:student_management_hive_api/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

final batchLocalDataSourceProvider = Provider.autoDispose<BatchLocalDataSource>(
        (ref) => BatchLocalDataSource(hiveService: ref.read(hiveServiceProvider))
);

class BatchLocalDataSource {
  final HiveService hiveService;

  BatchLocalDataSource({
    required this.hiveService,
  });

  // Add Batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try{
      BatchHiveModel batchHiveModel = BatchHiveModel.toHiveModel(batch);
      hiveService.addBatch(batchHiveModel);
      return const Right(true);
    } catch (e){
      return(Left(Failure(error: e.toString())));
    }
  }

  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      List<BatchHiveModel> batches = await hiveService.getAllBatches();
      List<BatchEntity> list = List.generate(
          batches.length, (index) => BatchHiveModel.toEntity(batches[index]));
      return Right(list);
    } catch (e){
      return(Left(Failure(error: e.toString())));
    }
  }
}
