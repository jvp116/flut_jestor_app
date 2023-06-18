import 'package:flut_jestor_app/services/user_service.dart';

class HomeController {
  bool isOut = false;

  Future<bool> logout(UserService service, String? accessToken) async {
    isOut = await service.logout(accessToken);
    return isOut;
  }
}
