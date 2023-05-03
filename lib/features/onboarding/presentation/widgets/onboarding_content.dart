import 'package:hebron_pay/constants.dart';

class OnboardingContent {
  final String image;
  final String tagline;

  OnboardingContent(this.image, this.tagline);
}

List<OnboardingContent> contents = [
  OnboardingContent(
    onboardingOne,
    'Experience lightning-fast payments with the simple scan of a QR code.',
  ),
  OnboardingContent(
    onboardingTwo,
    'Skip the line by generating your tickets online with our app.',
  ),
  OnboardingContent(
    onboardingThree,
    'Experience the speed and convenience of our secure payment feature.',
  )
];
