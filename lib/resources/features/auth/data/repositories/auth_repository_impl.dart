import '../../../../core/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasourece;

  AuthRepositoryImpl({required this.authDatasourece});

  @override
  Future<Result<void>> sendOTP(String phoneNumber) async {
    return await authDatasourece.sendOTP(phoneNumber);
  }

  @override
  Future<Result<void>> login(String phoneNumber, String otp) async {
    return await authDatasourece.login(phoneNumber, otp);
  }

  @override
  Future<Result<void>> register(
    String fullName,
    String phoneNumber,
    String governorate,
    String avatar,
  ) async {
    return await authDatasourece.register(
      name: fullName,
      phoneNumber: phoneNumber,
      governorateId: governorate,
      filePath: avatar,
    );
  }
}
