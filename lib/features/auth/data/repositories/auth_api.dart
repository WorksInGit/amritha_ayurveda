import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:amritha_ayurveda/core/constants/api_constants.dart';
import 'package:amritha_ayurveda/features/auth/data/models/login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(ApiConstants.login)
  @FormUrlEncoded()
  Future<LoginResponse> login(
    @Field('username') String username,
    @Field('password') String password,
  );
}
