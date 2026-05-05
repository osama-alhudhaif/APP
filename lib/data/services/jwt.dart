// Oda uses Django Token auth (not JWT).
// This file is reserved for future JWT decode utilities if needed.

class JwtHelper {
  static bool isExpired(String token) => false;
  static String? getUsername(String token) => null;
}
