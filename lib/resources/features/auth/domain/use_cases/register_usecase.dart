import '../../../../core/utils/result.dart';
import '../../data/repositories/auth_repository_impl.dart';

class RegisterUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  RegisterUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call(
    String fullName,
    String phoneNumber,
    String governorate,
    String avatar,
  ) async {
    return await authRepositoryImpl.register(
      fullName,
      phoneNumber,
      governorate,
      avatar,
    );
  }
}
