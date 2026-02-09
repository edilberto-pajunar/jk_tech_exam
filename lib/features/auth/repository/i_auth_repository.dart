import 'package:dio/dio.dart';
import 'package:jk_tech_exam/client/api/api_client.dart';
import 'package:jk_tech_exam/client/model/api_exceptions.dart';
import 'package:jk_tech_exam/features/auth/repository/auth_repository.dart';
import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';
import 'package:collection/collection.dart';

class IAuthRepository extends ApiClient implements AuthRepository {
  IAuthRepository() : super(dio: Dio());

  bool _validateEmail(String email) {
    final user = AppUser.getUsers().firstWhereOrNull(
      (user) => user.email == email,
    );
    return user != null;
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final validateEmail = _validateEmail(email);
    if (!validateEmail) {
      throw ApiExceptions("User not found", statusCode: 404);
    }

    final response = await post<Map<String, dynamic>>(
      "/login",
      data: {"email": email, "password": password},
    );
    final currentUser = AppUser.getUsers().firstWhere(
      (user) => user.email == email,
    );
    return currentUser.copyWith(token: response.data?["token"]);
  }

  @override
  Future<AppUser> validateEmail(String email) async {
    final AppUser? user = AppUser.getUsers().firstWhereOrNull(
      (user) => user.email == email,
    );
    if (user == null) {
      throw ApiExceptions("User not found");
    }
    // if (user.status == AppUserStatus.inactive) {
    //   throw Exception('User is inactive');
    // }
    return AppUser.getUsers().where((user) => user.email == email).first;
  }

  @override
  Future<void> createAccount({
    required String password,
    required String email,
  }) async {
    final response = await post(
      "/register",
      data: {"email": email, "password": password},
    );
    print(response);
  }
}
