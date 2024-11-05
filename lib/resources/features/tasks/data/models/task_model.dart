import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.description,
    required super.address,
    required super.governorateId,
    required super.date,
    required super.media,
    required super.lat,
    required super.lng,
    required super.statusId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      lng: json['lng'],
      lat: json['lat'],
      governorateId: json['governorate_id'].toString(),
      date: json['created_at'] ?? '',
      media: (json['media'] as List<dynamic>)
          .map((item) => item['path'] as String)
          .toList(),
      statusId: json['status_id'],
    );
  }

  Map<String, String> toJson() {
    return {
      'description': description,
      'address': address,
      'lng': lng,
      'lat': lat,
      'governorate_id': governorateId,
    };
  }
}
