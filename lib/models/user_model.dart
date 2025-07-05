import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  // Login response fields
  String? username;
  String? email;
  String? empCode;
  String? role;
  String? tokenType;
  String? accessToken;

  // Decoded JWT payload
  Map<String, dynamic>? jwtPayload;

  // Utility: full name
  String get fullName {
    if (jwtPayload != null) {
      return '${jwtPayload!['firstName']} ${jwtPayload!['lastName']}';
    }
    return '';
  }

  void setUser({
    required String username,
    required String email,
    required String empCode,
    required String role,
    required String tokenType,
    required String accessToken,
    required Map<String, dynamic> jwtPayload,
  }) {
    this.username = username;
    this.email = email;
    this.empCode = empCode;
    this.role = role;
    this.tokenType = tokenType;
    this.accessToken = accessToken;
    this.jwtPayload = jwtPayload;
    notifyListeners();
  }

  void clear() {
    username = null;
    email = null;
    empCode = null;
    role = null;
    tokenType = null;
    accessToken = null;
    jwtPayload = null;
    notifyListeners();
  }
}
