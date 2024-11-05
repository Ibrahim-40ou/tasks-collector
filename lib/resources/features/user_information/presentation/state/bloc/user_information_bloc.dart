import 'package:abm/main.dart';
import 'package:abm/resources/core/services/image_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/https_consumer.dart';
import '../../../../../core/services/internet_services.dart';
import '../../../../../core/utils/result.dart';
import '../../../data/datasources/user_information_datasource.dart';
import '../../../data/repositories/user_information_repository_impl.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/fetch_current_user_usecase.dart';
import '../../../domain/use_cases/update_user_information_use_case.dart';

part 'user_information_events.dart';

part 'user_information_states.dart';

class UserInformationBloc
    extends Bloc<UserInformationEvent, UserInformationState> {
  late UserEntity userInfo = UserEntity(
    name: '',
    phoneNumber: '',
    governorate: '',
    avatar: '',
  );

  UserInformationBloc() : super(UserInformationInitial()) {
    on<FetchCurrentUserInformation>(_fetchCurrentUserInformation);
    on<UpdateUserInformation>(_updateUserInformation);
  }

  void _fetchCurrentUserInformation(
    FetchCurrentUserInformation event,
    Emitter<UserInformationState> emit,
  ) async {
    emit(FetchCurrentUserInformationLoading());
    if (await ConnectionServices().isInternetAvailable()) {
      final Result result = await FetchCurrentUserUsecase(
        userInformationRepositoryImpl: UserInformationRepositoryImpl(
          userInformationDataSource: UserInformationDataSource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call();
      if (result.isSuccess) {
        userInfo = result.data;
        _setPreferences(userInfo, true);
        emit(FetchCurrentUserInformationSuccess(userData: userInfo));
      } else {
        return emit(FetchCurrentUserInformationFailure(failure: result.error));
      }
    } else {
      return emit(
        FetchCurrentUserInformationSuccess(
          userData: _getPreferences(),
        ),
      );
    }
  }

  void _updateUserInformation(
    UpdateUserInformation event,
    Emitter<UserInformationState> emit,
  ) async {
    emit(UpdateUserInformationLoading());
    if (await ConnectionServices().isInternetAvailable()) {
      emit(UpdateUserInformationLoading());
      final Result result = await UpdateUserInformationUseCase(
        userInformationRepositoryImpl: UserInformationRepositoryImpl(
          userInformationDataSource: UserInformationDataSource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call(
        event.fullName,
        event.avatar,
        event.governorate,
      );
      if (result.isSuccess) {
        userInfo.name = event.fullName;
        userInfo.avatar = event.avatar;
        userInfo.governorate = event.governorate;
        userInfo.phoneNumber = event.phoneNumber;
        emit(UpdateUserInformationSuccess());
        _setPreferences(userInfo, false);
        return emit(FetchCurrentUserInformationSuccess(userData: userInfo));
      } else {
        emit(UpdateUserInformationFailure(failure: result.error));
      }
    } else {
      emit(UpdateUserInformationLoading());
      userInfo.name = event.fullName;
      userInfo.avatar = event.avatar;
      userInfo.governorate = event.governorate;
      userInfo.phoneNumber = event.phoneNumber;
      _setPreferences(userInfo, false);
      emit(UpdateUserInformationSuccess());
      return emit(FetchCurrentUserInformationSuccess(userData: userInfo));
    }
  }

  void _setPreferences(UserEntity userInfo, bool uploadAvatar) async {
    preferences!.setString('name', userInfo.name ?? '');
    preferences!.setString('phone_number', userInfo.phoneNumber);
    preferences!.setString('governorate', userInfo.governorate ?? '');
    preferences!.setString(
      'avatar',
      userInfo.avatar != null && uploadAvatar
          ? await ImageService().downloadImage(userInfo.avatar!)
          : userInfo.avatar ?? '',
    );
  }

  UserEntity _getPreferences() {
    return UserEntity(
      name: preferences!.getString('name'),
      phoneNumber: preferences!.getString('phone_number') ?? '',
      governorate: preferences!.getString('governorate_id'),
      avatar: preferences!.getString('avatar'),
    );
  }
}
