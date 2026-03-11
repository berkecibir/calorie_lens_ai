class AppTexts {
  // App Pages ID's here.
  static const String signInPageId = 'sign_in_page_id';
  static const String signUpPageId = 'sign_up_page_id';
  static const String onboardingPageId = 'onboarding_page_id';
  static const String onboardingWizardPageId = "onboarding_wizard_page";
  static const String splashPageId = 'splash_page';
  static const String forgotPasswordPageId = 'forgot_password_page';
  static const String mainPageId = 'main_page_id';

  // App Name
  static const String appName = 'CalorieLens AI';

  // UserModel Strings

  static const String email = 'email';
  static const String displayName = 'displayName';
  static const String photoUrl = 'photoUrl';
  static const String createdAt = 'createdAt';
  static const String lastLogin = 'lastLogin';
  static const String uid = 'uid';
  static const String isEmailVerified = 'isEmailVerified';

  // Env Assets path String
  static const String envPath = "assets/.env";
  static const String envError = "⚠️ Environment loading error:";

  // Auth Pages Strings

  static const String welcomeText = 'Hoş Geldiniz!';

  // Auth Model Strings
  static const String empty = '';

  // User Profile Model Strings
  static const String gender = 'gender';
  static const String activityLevel = 'activityLevel';
  static const String age = 'age';
  static const String heightCm = 'heightCm';
  static const String weightKg = 'weightKg';
  static const String targetWeightKg = 'targetWeightKg';
  static const String dietType = 'dietType';
  static const String allergies = 'allergies';

  // Auth Local Data Source Strings

  static const String authUserSession = 'user_session';
  static const String authToken = 'auth_token';
  static const String failedToSaveUserSession = 'Failed to save user session:';
  static const String failedCachedUserSession =
      'Failed to get cached user session:';
  static const String failedToClearUserSession =
      'Failed to clear user session:';

  static const String failedUpdateCachedUser = 'Failed to update cached user:';
  static const String failedToSaveAuthToken = 'Failed to save auth token:';
  static const String failedToGetAuthToken = 'Failed to get auth token:';
  static const String failedToClearAuthToken = 'Failed to clear auth token:';

  // Auth Remote Data Source Strings
  static const String firestoreTableName = 'users';
  static const String passwordResetFailMessage =
      'Şifre sıfırlama e-postası gönderilemedi:';
  static const String loginFailedMessage = 'Giriş yapılamadı.';
  static const String registrationFailedMessage = 'Kullanıcı kaydı başarısız.';
  static const String failedToUpdateLastLogin =
      'Son giriş tarihi güncellenemedi:';
  static const String updateUserInfoFailMessage =
      'Kullanıcı oturumu açık değil.';
  static const String userInfoFailMessage =
      'Kullanıcı bilgileri güncellenemedi:';

  // Auth Text Form Fields Strings

  static const String emailLabelText = 'Email';
  static const String passwordLabelText = 'Parola';
  static const String confirmPasswordLabelText = 'Parola Onay';
  static const String fullNameLabelText = 'Ad Soyad';

  // Onboarding Wizard Nutrition Calculation Util Strings
  static const String profileInfoNotCompleted =
      "Eksik profil bilgisi: Ağırlık, boy, yaş, cinsiyet ve hedef kilo gerekli!";

  // Onboarding Wizard Hive Strings
  static const String onboardingWizarBoxName = 'onboarding_wizard_box';
  static const String onboardingWizardUserProfileKey = 'userProfile';
  static const String onboardingWizardCompletedKey = 'wizardCompleted';

  // Onboarding Wizard Form Strings
  static const String bmr = 'bmr';
  static const String tdee = 'tdee';
  static const String dailyCalorieGoal = 'dailyCalorieGoal';
  static const String proteinGrams = 'proteinGrams';
  static const String carbGrams = 'carbGrams';
  static const String fatGrams = 'fatGrams';
  static const String insightMessage = 'insightMessage';

  // Onboarding Wizard Cubit Strings
  static const String profileLoadFailedMessage = 'Profil yüklenemedi:';
  static const String checkWizardStatusFailedMessage =
      'Wizard durumu kontrol edilemedi:';
  static const String wizardCompletedAlready = "Wizard zaten tamamlanmış";

  // Splash Cubit Strings
  static const String splashError = 'Başlatma sırasında hata oluştu:';

  // Debug Check Profile
  static const String profileBeingSaved = '📋 Profile being saved:';
  static const String genderDebug = '- Gender:';
  static const String ageDebug = '- Age:';
  static const String heightDebug = '- Height:';
  static const String weightDebug = '- Weight:';
  static const String targetWeightDebug = '- Target Weight:';
  static const String activityDebug = '- Activity:';
  //-----------------------------------------------------------------------------
  static const String profileSavedFailedMessage = '"Profil kaydedilemedi"';
  static const String nutritionCalculationFailedMessage =
      '❌ Nutrition calculation failed:';
  static const String nutritionCalculationErrorMessage =
      'Besin hesaplama hatası:';
  static const String wizardCouldNotUpdateMessage =
      'Wizard durumu güncellenemedi:';
  static const String wizardCompletedSuccessfully =
      "Wizard başarıyla tamamlandı!";

  // Appbar Titles

  static const String authAppbarTitle = 'Kayıt Ol';

  // Validator Strings

  static const validateFormMessage = 'Bu alan boş geçilemez';
  static const validateEmailMessage = 'E-posta boş geçilemez';
  static const validateRegexcontrollMessage =
      'Geçerli bir e-posta adresi giriniz';
  static const validatePasswordMessage = 'Şifre boş geçilemez';
  // Validator RegExp Strings
  static const authRegExp = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const decimalWeightRegExp = r'^\d+(\.\d{1,2})?$';
  static String validatePasswordLengthMessage(int minLength) {
    return 'Şifre en az $minLength karakter olmalıdır';
  }

  static const String nameAndSurnameCantBeEmpty = 'Ad ve soyad boş geçilemez';
  static const String atLeastThreeCharacters = 'En az 3 karakter olmalıdır';
  static const String passwordDoNotMatch = 'Parolalar eşleşmiyor';

  // Sign in Page Strings
  static const String signInErrorOccured = 'Giriş Hatası:';
  static const String signInTitleSectionWelcomeAgain = 'Tekrar Hoş Geldiniz';
  static const String signInTitleSectionWelcomeAgainSubTitle =
      'Hesabınıza giriş yapın';
  static const String signInLoadingSectionLoadingText = 'Giriş yapılıyor...';
  static const String signInFormForgotPasswordText = 'Şifremi Unuttum?';
  static const String dontHaveAccountText = 'Hesabınız yok mu? ';

  // Sign Up Page Strings
  static const String signUpErrorOccured = 'Kayıt Hatası:';
  static const String createAnAccount = 'Hesap Oluştur';
  static const String signUpDescriptionText = 'Hemen başlamak için kayıt olun';
  static const String creatingAccountText = 'Hesabınız oluşturuluyor...';

  // button title
  static const String continueText = 'Devam Et';
  static const String calculateAndStartText = 'Hesapla ve Başla';
  static const String signInText = 'Giriş Yap';
  static const String signUpText = 'Kayıt Ol';
  static const String haveAccountText = 'Zaten hesabınız var mı? ';

  // Forgot Password Page Strings
  static const String resetPasswordTitle = 'Şifre Sıfırlama';
  static const String resetPasswordSubtitle =
      'E-posta adresinize sıfırlama bağlantısı gönderelim';
  static const String sendResetLinkButtonText = 'Bağlantı Gönder';
  static const String backToSignInText = 'Giriş ekranına dön';
  static const String resetEmailSentMessage =
      'Şifre sıfırlama bağlantısı e-postası adresinize gönderildi.';

  // Email Verification Page Strings
  static const String emailVerificationPageId = 'email_verification_page';
  static const String verifyEmailTitle = 'E-posta Adresinizi Doğrulayın';
  static const String verifyEmailDescription =
      'Lütfen e-posta adresinize gönderdiğimiz bağlantıya tıklayarak hesabınızı doğrulayın. Doğrulama yaptıktan sonra "Doğrulamayı Kontrol Et" butonuna tıklayın.';
  static const String checkVerificationButtonText = 'Doğrulamayı Kontrol Et';
  static const String resendEmailButtonText = 'E-postayı Tekrar Gönder';
  static const String cancelAndLogoutButtonText = 'Vazgeç ve Çıkış Yap';
  static const String emailVerificationSentMessage =
      'Doğrulama e-postası tekrar gönderildi.';
}
