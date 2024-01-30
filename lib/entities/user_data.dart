import 'package:stocks_tracking_app/entities/current_request_status.dart';

class UserData {
  final String email;
  final String token;
  final bool isLogin;
  final CurrentRequestStatus currentRequest = CurrentRequestStatus('', 0);

  UserData({required this.email, required this.token, required this.isLogin});
}
