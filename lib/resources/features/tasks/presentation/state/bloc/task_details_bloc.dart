import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/https_consumer.dart';
import '../../../../../core/services/internet_services.dart';
import '../../../../../core/utils/result.dart';
import '../../../data/datasources/tasks_datasource.dart';
import '../../../data/repositories/tasks_repository_impl.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/use_cases/fetch_task_by_id_use_case.dart';

part 'task_details_events.dart';

part 'task_details_states.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsStates> {
  TaskDetailsBloc() : super(TaskDetailsInitial()) {
    on<FetchTaskByID>(_fetchTaskByID);
  }

  @override
  void onChange(Change<TaskDetailsStates> change) {
    // TODO: implement onChange
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }

  Future<void> _fetchTaskByID(
    FetchTaskByID event,
    Emitter<TaskDetailsStates> emit,
  ) async {
    emit(FetchTaskByIDLoading());
    if (await InternetServices().isInternetAvailable()) {
      final Result result = await FetchTaskByIDUseCase(
        tasksRepositoryImpl: TasksRepositoryImpl(
          tasksDatasource: TasksDatasource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call(event.id);
      if (result.isSuccess) {
        return emit(FetchTaskByIDSuccess(task: result.data));
      } else {
        return emit(FetchTaskByIDFailure(failure: result.error));
      }
    } else {
      return emit(FetchTaskByIDFailure(failure: 'no internet connection'.tr()));
    }

  }
}
