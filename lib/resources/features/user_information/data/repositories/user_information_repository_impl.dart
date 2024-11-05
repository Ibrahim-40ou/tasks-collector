import '../../../../core/utils/result.dart';
import '../../domain/repositories/user_information_repository.dart';
import '../datasources/user_information_datasource.dart';

class UserInformationRepositoryImpl extends UserInformationRepository {
  final UserInformationDataSource userInformationDataSource;

  UserInformationRepositoryImpl({required this.userInformationDataSource});

  @override
  Future<Result<void>> fetchCurrentUser() async {
    return await userInformationDataSource.fetchCurrentUser();
  }

  @override
  Future<Result<void>> updateUserInformation(
    String fullName,
    String avatar,
    String governorate,
  ) async {
    return await userInformationDataSource.updateUserInformation(
      name: fullName,
      governorateId: governorate,
      filePath: avatar,
    );
  }
}
