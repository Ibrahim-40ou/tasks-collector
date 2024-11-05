class TaskEntity {
  late int id;
  late String description;
  late String address;
  late String lng;
  late String lat;
  late String governorateId;
  late String date;
  late List<String> media;
  late int statusId;

  TaskEntity({
    required this.id,
    required this.description,
    required this.address,
    required this.lat,
    required this.lng,
    required this.governorateId,
    required this.date,
    required this.media,
    required this.statusId,
  });
}
