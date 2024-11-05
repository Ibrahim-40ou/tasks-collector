import '../../../../core/api/https_consumer.dart';
import '../../../../core/cache/database_helper.dart';
import '../../../../core/services/image_services.dart';
import '../../../../core/services/internet_services.dart';
import '../../data/models/task_model.dart';
import '../../domain/entities/task_entity.dart';

class LocalTasksDatasource {
  final DatabaseHelper databaseHelper;
  final ImageService imageService;
  final HttpsConsumer httpsConsumer;

  LocalTasksDatasource({
    required this.databaseHelper,
    required this.imageService,
    required this.httpsConsumer,
  });

  Future<List<TaskEntity>> fetchTasks() async {
    return await databaseHelper.getAllTasks();
  }

  Future<void> storeTasks(List<TaskEntity> newTasks) async {
    await databaseHelper.deleteAllTasks();
    final List<TaskModel> tasksToInsert = [];
    for (TaskEntity taskEntity in newTasks) {
      final task = TaskModel(
        id: taskEntity.id,
        description: taskEntity.description,
        address: taskEntity.address,
        lat: taskEntity.lat,
        lng: taskEntity.lng,
        governorateId: taskEntity.governorateId,
        date: taskEntity.date,
        media: taskEntity.media,
        statusId: taskEntity.statusId,
      );
      List<String> localImagePaths = [];
      for (String imageUrl in task.media) {
        String localPath = await imageService.downloadImage(imageUrl);
        localImagePaths.add(localPath);
      }
      task.media = localImagePaths;
      tasksToInsert.add(task);
    }
    for (TaskModel task in tasksToInsert) {
      if (await InternetServices().isInternetAvailable()) {
        await databaseHelper.insertTask(task, 'uploaded');
      } else {
        await databaseHelper.insertTask(task, 'waiting');
      }
    }
    databaseHelper.printAllTasks();
  }

  Future<void> addTask(TaskEntity task) async {
    if (await InternetServices().isInternetAvailable()) {
      await databaseHelper.insertTask(task, 'uploaded');
      databaseHelper.printAllTasks();
    } else {
      await databaseHelper.insertTask(task, 'waiting');
      databaseHelper.printAllTasks();
    }
  }

  Future<void> deleteTask(int id) async {
    await databaseHelper.markTaskAsDeleted(id);
  }

  Future<void> deleteAllWaitingTasks() async {
    await databaseHelper.deleteAllWaitingTasks();
  }

  Future<void> deleteAllDeletedTasks() async {
    await databaseHelper.deleteAllDeletedTasks();
  }
}
