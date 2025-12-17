abstract class OnboardingLocalDataSource {
  Future<bool> checkOnboardingStatus();
  Future<void> completeOnboarding();
}
