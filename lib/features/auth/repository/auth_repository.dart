import 'package:jk_tech_exam/features/dashboard/community/data/model/user.dart';

abstract class AuthRepository {
  Future<AppUser> validateEmail(String email);
  Future<AppUser> login({required String email, required String password});
  Future<AppUser> createAccount({required String password, required String email});
}
