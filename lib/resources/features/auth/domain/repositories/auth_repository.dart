abstract class AuthRepository {
  Future<void> sendOTP(String phoneNumber);

  Future<void> login(String phoneNumber, String otp);

  Future<void> register(
    String fullName,
    String phoneNumber,
    String governorate,
    String avatar,
  );
}
