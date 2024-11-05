import 'package:abm/resources/core/cache/database_helper.dart';
import 'package:abm/resources/core/services/image_services.dart';
import 'package:abm/resources/core/services/internet_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/https_consumer.dart';
import '../../../../../core/utils/result.dart';
import '../../../data/datasources/local_tasks_datasource.dart';
import '../../../data/datasources/tasks_datasource.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repositories/tasks_repository_impl.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/add_task_use_case.dart';
import '../../../domain/use_cases/delete_task_use_case.dart';
import '../../../domain/use_cases/fetch_tasks_use_case.dart';

part 'tasks_events.dart';

part 'tasks_states.dart';

class TasksBloc extends Bloc<TasksEvents, TasksStates> {
  late List<TaskEntity> tasks = [];

  TasksBloc() : super(TasksInitial()) {
    on<FetchTasks>(_fetchTasks);
    on<AddTask>(_addTask);
    on<NoImages>(_noImages);
    on<DeleteTask>(_deleteTask);
    on<UploadOfflineTasks>(_upload);
    on<DeleteOfflineTasks>(_delete);
    on<SerializationEvent>(_serialize);
  }

  Future<void> _serialize(
    SerializationEvent event,
    Emitter<TasksStates> emit,
  ) async {
    DatabaseHelper().printAllTasks();
    await _upload(UploadOfflineTasks(), emit);
    await _delete(DeleteOfflineTasks(), emit);
    await _fetchTasks(FetchTasks(), emit);
  }

  Future<void> _upload(
    UploadOfflineTasks event,
    Emitter<TasksStates> emit,
  ) async {
    emit(UploadedOfflineTasksLoading());
    try {
      if (await ConnectionServices().isInternetAvailable()) {
        final List<TaskModel> tasksToUpload =
            await DatabaseHelper().getWaitingTasks();
        bool success = true;
        for (TaskModel task in tasksToUpload) {
          final Result<void> result = await AddTaskUseCase(
            tasksRepositoryImpl: TasksRepositoryImpl(
              tasksDatasource: TasksDatasource(
                httpsConsumer: HttpsConsumer(),
              ),
            ),
          ).call(task);
          if (!result.isSuccess) {
            success = false;
          }
        }
        if (success) {
          await LocalTasksDatasource(
            databaseHelper: DatabaseHelper(),
            imageService: ImageService(),
            httpsConsumer: HttpsConsumer(),
          ).deleteAllWaitingTasks();
        }
      }
      return emit(UploadedOfflineTasksSuccess());
    } on Exception catch (e) {
      return emit(UploadedOfflineTasksFailure(failure: '$e'));
    }
  }

  Future<void> _delete(
    DeleteOfflineTasks event,
    Emitter<TasksStates> emit,
  ) async {
    emit(DeletedOfflineTasksLoading());
    try {
      if (await ConnectionServices().isInternetAvailable()) {
        final List<TaskModel> tasksToDelete =
            await DatabaseHelper().getDeletedTasks();
        bool success = true;
        for (TaskModel task in tasksToDelete) {
          final Result<void> result = await DeleteTasksUseCase(
            tasksRepositoryImpl: TasksRepositoryImpl(
              tasksDatasource: TasksDatasource(
                httpsConsumer: HttpsConsumer(),
              ),
            ),
          ).call(task.id);
          if (!result.isSuccess) {
            success = false;
          }
        }
        if (success) {
          await LocalTasksDatasource(
            databaseHelper: DatabaseHelper(),
            imageService: ImageService(),
            httpsConsumer: HttpsConsumer(),
          ).deleteAllDeletedTasks();
        }
      }
      return emit(DeletedOfflineTasksSuccess());
    } on Exception catch (e) {
      return emit(DeletedOfflineTasksFailure(failure: '$e'));
    }
  }

  @override
  void onChange(Change<TasksStates> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }

  void _deleteTask(
    DeleteTask event,
    Emitter<TasksStates> emit,
  ) async {
    if (await ConnectionServices().isInternetAvailable()) {
      final result = await DeleteTasksUseCase(
        tasksRepositoryImpl: TasksRepositoryImpl(
          tasksDatasource: TasksDatasource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call(event.id);
      if (result.isSuccess) {
        tasks.removeAt(event.index);
        await LocalTasksDatasource(
          databaseHelper: DatabaseHelper(),
          imageService: ImageService(),
          httpsConsumer: HttpsConsumer(),
        ).deleteTask(event.id);
        return emit(FetchTasksSuccess(tasks: tasks));
      } else {
        return emit(DeleteTaskFailure(failure: result.error));
      }
    } else {
      await LocalTasksDatasource(
        databaseHelper: DatabaseHelper(),
        imageService: ImageService(),
        httpsConsumer: HttpsConsumer(),
      ).deleteTask(event.id);
      tasks.removeAt(event.index);
      return emit(FetchTasksSuccess(tasks: tasks));
    }
  }

  void _noImages(
    NoImages event,
    Emitter<TasksStates> emit,
  ) {
    return emit(NoImagesState());
  }

  Future<void> _fetchTasks(
    FetchTasks event,
    Emitter<TasksStates> emit,
  ) async {
    emit(FetchTasksLoading());
    if (await ConnectionServices().isInternetAvailable()) {
      final Result result = await FetchTasksUseCase(
        tasksRepositoryImpl: TasksRepositoryImpl(
          tasksDatasource: TasksDatasource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call();
      if (result.isSuccess) {
        tasks = result.data;
        await LocalTasksDatasource(
          databaseHelper: DatabaseHelper(),
          imageService: ImageService(),
          httpsConsumer: HttpsConsumer(),
        ).storeTasks(tasks);
        return emit(FetchTasksSuccess(tasks: tasks));
      } else {
        return emit(FetchTasksFailure(failure: result.error));
      }
    }
    tasks = await LocalTasksDatasource(
      databaseHelper: DatabaseHelper(),
      imageService: ImageService(),
      httpsConsumer: HttpsConsumer(),
    ).fetchTasks();
    return emit(FetchTasksSuccess(tasks: tasks));
  }

  Future<void> _addTask(
    AddTask event,
    Emitter<TasksStates> emit,
  ) async {
    emit(AddTaskLoading());
    if (await ConnectionServices().isInternetAvailable()) {
      final Result result = await AddTaskUseCase(
        tasksRepositoryImpl: TasksRepositoryImpl(
          tasksDatasource: TasksDatasource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call(event.task);
      if (result.isSuccess) {
        await LocalTasksDatasource(
          databaseHelper: DatabaseHelper(),
          imageService: ImageService(),
          httpsConsumer: HttpsConsumer(),
        ).addTask(event.task);
        tasks.add(event.task);
        emit(AddTaskSuccess());
        return emit(FetchTasksSuccess(tasks: tasks));
      } else {
        return emit(AddTaskFailure(failure: result.error));
      }
    } else {
      await LocalTasksDatasource(
        databaseHelper: DatabaseHelper(),
        imageService: ImageService(),
        httpsConsumer: HttpsConsumer(),
      ).addTask(event.task);
      tasks.add(event.task);
      emit(AddTaskSuccess());
      emit(FetchTasksSuccess(tasks: tasks));
    }
  }
}
