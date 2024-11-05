part of 'user_information_bloc.dart';

@immutable
sealed class UserInformationState {}

class UserInformationInitial extends UserInformationState {}

class FetchCurrentUserInformationLoading extends UserInformationState {}

class FetchCurrentUserInformationSuccess extends UserInformationState {
  final UserEntity userData;

  FetchCurrentUserInformationSuccess({required this.userData});
}

class FetchCurrentUserInformationFailure extends UserInformationState {
  final String? failure;

  FetchCurrentUserInformationFailure({required this.failure});
}

class UpdateUserInformationLoading extends UserInformationState {}

class UpdateUserInformationSuccess extends UserInformationState {}

class UpdateUserInformationFailure extends UserInformationState {
  final String? failure;

  UpdateUserInformationFailure({required this.failure});
}
