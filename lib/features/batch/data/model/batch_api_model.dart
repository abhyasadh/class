import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/batch_entity.dart';

@JsonSerializable()
class BatchAPIModel{
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  BatchAPIModel({this.batchId, required this.batchName});

  factory BatchAPIModel.fromJson(Map<String, dynamic> json) {
    return BatchAPIModel(
      batchId: json['_id'],
      batchName: json['batchName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batchName': batchName,
    };
  }

  // From entity to model
  factory BatchAPIModel.fromEntity(BatchEntity entity) {
    return BatchAPIModel(
      batchName: entity.batchName,
    );
  }

  // From model to entity
  static BatchEntity toEntity(BatchAPIModel model) {
    return BatchEntity(
      batchId: model.batchId,
      batchName: model.batchName,
    );
  }
}