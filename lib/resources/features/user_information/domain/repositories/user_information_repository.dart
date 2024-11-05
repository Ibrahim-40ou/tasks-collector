abstract class UserInformationRepository {
  Future<void> fetchCurrentUser();

  Future<void> updateUserInformation(
    String fullName,
    String avatar,
    String governorate,
  );
}
