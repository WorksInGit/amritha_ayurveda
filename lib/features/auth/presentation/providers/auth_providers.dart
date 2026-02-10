import 'package:amritha_ayurveda/core/providers.dart';
import 'package:amritha_ayurveda/features/auth/data/repositories/auth_api.dart';
import 'package:amritha_ayurveda/features/auth/data/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
AuthApi authApi(AuthApiRef ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final api = ref.watch(authApiProvider);
  return AuthRepository(api);
}
