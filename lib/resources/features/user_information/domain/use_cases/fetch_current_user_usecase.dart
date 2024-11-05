import '../../../../core/utils/result.dart';
import '../../data/repositories/user_information_repository_impl.dart';

class FetchCurrentUserUsecase {
  final UserInformationRepositoryImpl userInformationRepositoryImpl;

  FetchCurrentUserUsecase({required this.userInformationRepositoryImpl});

  Future<Result<void>> call() async {
    return await userInformationRepositoryImpl.fetchCurrentUser();
  }
}
