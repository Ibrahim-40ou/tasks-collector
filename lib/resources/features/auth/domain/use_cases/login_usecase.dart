import '../../../../core/utils/result.dart';
import '../../data/repositories/auth_repository_impl.dart';

class LoginUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  LoginUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call(String phoneNumber, String otp) async {
    return await authRepositoryImpl.login(phoneNumber, otp);
  }
}
