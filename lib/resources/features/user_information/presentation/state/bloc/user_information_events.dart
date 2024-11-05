part of 'user_information_bloc.dart';

@immutable
sealed class UserInformationEvent {}

class FetchCurrentUserInformation extends UserInformationEvent {}

class UpdateUserInformation extends UserInformationEvent {
  final String fullName;
  final String avatar;
  final String governorate;
  final String phoneNumber;

  UpdateUserInformation({
    required this.fullName,
    required this.avatar,
    required this.governorate,
    required this.phoneNumber,
  });
}

class SerializationUserEvent extends UserInformationEvent {}
