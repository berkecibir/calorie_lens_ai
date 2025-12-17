import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String getMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'Geçersiz e-posta adresi.';
      case 'user-disabled':
        return 'Kullanıcı devre dışı bırakılmış.';
      case 'user-not-found':
        return 'Kullanıcı bulunamadı.';
      case 'wrong-password':
        return 'Girdiğiniz parola hatalı.';
      case 'email-already-in-use':
        return 'Bu e-posta ile zaten kayıt yapılmış.';
      case 'weak-password':
        return 'Parola zayıf. Daha güçlü bir parola seçin.';
      case 'requires-recent-login':
        return 'Bu işlemi gerçekleştirmek için tekrar giriş yapmanız gerekiyor.';
      case 'network-request-failed':
        return 'İnternet bağlantınızı kontrol edin.';
      case 'too-many-requests':
        return 'Çok fazla başarısız deneme yaptınız. Lütfen daha sonra tekrar deneyin.';
      case 'operation-not-allowed':
        return 'Bu işlem şu anda kullanılamıyor.';
      case 'credential-already-in-use':
        return 'Bu kimlik bilgileri başka bir hesap tarafından kullanılıyor.';
      default:
        return 'Bir hata oluştu. Lütfen tekrar deneyin. ($errorCode)';
    }
  }

  static String handleAuthException(FirebaseAuthException e) {
    return getMessage(e.code);
  }
}
