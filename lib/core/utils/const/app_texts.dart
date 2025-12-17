class AppTexts {
  // App Pages ID's here.
  static const String signInPageId = 'sign_in_page_id';
  static const String signUpPageId = 'sign_up_page_id';
  static const String onboardingPageId = 'onboarding_page_id';

  // Onboarding Cubit Texts
  static const String checkInitialScreenErrorMessage =
      'Failed to check onboarding status';
  static const String completeOnboardingErrorMessage =
      'Failed to complete onboarding';

  // Onboarding Pages Texts
  static const String onboardingLastPageBodyMessage =
      'KaloriLens AI uygulamasını kullanmaya başlamak için aşağıdaki butona tıklayın.';
  static const String onboardingLastPageButtonTitle = 'Başlayalım';
  static const String onboardingFirstPageTitle = 'Yemeklerinizi Tanıyın';
  static const String onboardingFirstPageBodyMessage =
      'Fotoğrafla yemeklerinizi tanımlayın ve otomatik kalori hesaplamasından yararlanın.';
  static const String onboardingSecondPageTitle = 'Beslenmenizi Takip Edin';
  static const String onboardingSecondPageBodyMessage =
      'Günlük beslenme alışkanlıklarınızı analiz edin ve hedeflerinize ulaşın.';
  static const String onboardingThirdPageTitle =
      'Sağlıklı Yaşamın Kilidine Ulaşın';
  static const String onboardingThirdPageBodyMessage =
      'Kişiye özel önerilerle sağlıklı yaşam hedeflerinize ulaşın.';

  // UserModel Strings

  static const String email = 'email';
  static const String displayName = 'displayName';
  static const String photoUrl = 'photoUrl';
  static const String createdAt = 'createdAt';
  static const String lastLogin = 'lastLogin';
  static const String uid = 'uid';
  static const String isEmailVerified = 'isEmailVerified';

  // Auth Pages Strings

  static const String welcomeText = 'Hoş Geldiniz!';

  // Auth Text Form Fields Strings

  static const String emailLabelText = 'Email';
  static const String passwordLabelText = 'Parola';
  static const String confirmPasswordLabelText = 'Parola Onay';
  static const String fullNameLabelText = 'Ad Soyad';

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
}
