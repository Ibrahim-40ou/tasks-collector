import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.phoneNumber,
    required super.governorate,
    required super.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      phoneNumber: json['phone'],
      avatar: json['avatar'] ?? '',
      governorate: json['governorate_id'] != null
          ? json['governorate_id'].toString()
          : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'governorate': governorate,
      'avatar': avatar,
    };
  }
}
