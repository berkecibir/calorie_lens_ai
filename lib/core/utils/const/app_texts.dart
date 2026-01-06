class AppTexts {
  // App Pages ID's here.
  static const String signInPageId = 'sign_in_page_id';
  static const String signUpPageId = 'sign_up_page_id';
  static const String onboardingPageId = 'onboarding_page_id';
  static const String onboardingWizardPageId = "onboarding_wizard_page";

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

  // Onboarding Wizard Cubit Strings
  static const String profileLoadFailedMessage = 'Profil yüklenemedi:';
  static const String checkWizardStatusFailedMessage =
      'Wizard durumu kontrol edilemedi:';
  static const String wizardCompletedAlready = "Wizard zaten tamamlanmış";

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
  static String validatePasswordLengthMessage(int minLength) {
    return 'Şifre en az $minLength karakter olmalıdır';
  }

  // Sign in Page Strings
  static const String signInErrorOccured = 'Giriş Hatası:';

  // Sign Up Page Strings
  static const String signUpErrorOccured = 'Kayıt Hatası:';

  // button title
  static const String continueText = 'Devam Et';
}
