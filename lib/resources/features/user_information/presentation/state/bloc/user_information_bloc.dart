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
    on<SerializationUserEvent>(_serialize);
  }

  @override
  void onChange(Change<UserInformationState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print('objects');
    print(change);
  }

  Future<void> _serialize(
    SerializationUserEvent event,
    Emitter<UserInformationState> emit,
  ) async {
    await _updateUserInformation(
      UpdateUserInformation(
        fullName: preferences!.getString('name') ?? '',
        avatar: preferences!.getString('avatar') ?? '',
        governorate: preferences!.getString('governorate_id') ?? '',
        phoneNumber: preferences!.getString('phone_number') ?? '',
      ),
      emit,
    );
    await _fetchCurrentUserInformation(
      FetchCurrentUserInformation(),
      emit,
    );
  }

  Future<void> _fetchCurrentUserInformation(
    FetchCurrentUserInformation event,
    Emitter<UserInformationState> emit,
  ) async {
    emit(FetchCurrentUserInformationLoading());
    if (await InternetServices().isInternetAvailable()) {
      final Result result = await FetchCurrentUserUsecase(
        userInformationRepositoryImpl: UserInformationRepositoryImpl(
          userInformationDataSource: UserInformationDataSource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call();
      if (result.isSuccess) {
        userInfo = result.data;
        await _setPreferences(userInfo, true);
        emit(FetchCurrentUserInformationSuccess(userData: userInfo));
      } else {
        return emit(FetchCurrentUserInformationFailure(failure: result.error));
      }
    } else {
      return emit(
        FetchCurrentUserInformationSuccess(
          userData: await _getPreferences(),
        ),
      );
    }
  }

  Future<void> _updateUserInformation(
    UpdateUserInformation event,
    Emitter<UserInformationState> emit,
  ) async {
    emit(UpdateUserInformationLoading());
    if (await InternetServices().isInternetAvailable()) {
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
        await _setPreferences(userInfo, false);
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
      await _setPreferences(userInfo, false);
      emit(UpdateUserInformationSuccess());
      return emit(FetchCurrentUserInformationSuccess(userData: userInfo));
    }
  }

  Future<void> _setPreferences(UserEntity userInfo, bool uploadAvatar) async {
    preferences!.setString('name', userInfo.name ?? '');
    preferences!.setString('phone_number', userInfo.phoneNumber);
    preferences!.setString('governorate_id', userInfo.governorate ?? '');
    preferences!.setString(
      'avatar',
      userInfo.avatar != null && uploadAvatar
          ? await ImageService().downloadImage(userInfo.avatar!)
          : userInfo.avatar ?? '',
    );
  }

  Future<UserEntity> _getPreferences() async {
    return UserEntity(
      name: preferences!.getString('name'),
      phoneNumber: preferences!.getString('phone_number') ?? '',
      governorate: preferences!.getString('governorate_id'),
      avatar: preferences!.getString('avatar'),
    );
  }
}
