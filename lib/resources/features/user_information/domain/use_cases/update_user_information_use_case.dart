import '../../../../core/utils/result.dart';
import '../../data/repositories/user_information_repository_impl.dart';

class UpdateUserInformationUseCase {
  final UserInformationRepositoryImpl userInformationRepositoryImpl;

  UpdateUserInformationUseCase({required this.userInformationRepositoryImpl});

  Future<Result<void>> call(
    String fullName,
    String avatar,
    String governorate,
  ) async {
    return await userInformationRepositoryImpl.updateUserInformation(
      fullName,
      avatar,
      governorate,
    );
  }
}
