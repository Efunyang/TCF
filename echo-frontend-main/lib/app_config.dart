import 'package:echo_frontend/utils/net_utils.dart';
import 'package:logger/logger.dart';

const kUseFakeRepos = String.fromEnvironment('useFakeRepos') == 'true';
const hyperTrackPublicKey = '6CbwdMYTuG7vI2-ZxAxZDGBEppk21uVlNXD6NO3cOfmXJ011osyUemo3cW8_Mi_fUCwGct_BbSZ-RZcVAZPVQA';
final log = Logger();

class ApiUrl {
  //static const baseUrl = "http://172.28.25.9:8000";
  static const baseUrl = "http://127.0.0.1:8000/";
  static List logIn = [DioMethod.post, "$baseUrl/auth/login"];
  //static List logIn = [DioMethod.post, "$baseUrl/auth/users"];
  static List signUp = [DioMethod.post, "$baseUrl/auth/signup"];
  static List logOut = [DioMethod.post, '$baseUrl/auth/logout'];
  static List refreshToken = [DioMethod.post, '$baseUrl/auth/refresh'];

  static List fetchProfile(String id) => [DioMethod.get, "$baseUrl/user/$id"];
  static List updateAvatar(String id) => [DioMethod.patch, "$baseUrl/user/$id/update_avatar"];
}
