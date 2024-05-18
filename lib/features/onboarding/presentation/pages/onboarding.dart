import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/sign_up.dart';
import 'package:hebron_pay/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const id = '/onboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const secureStorage = FlutterSecureStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () async {
              Navigator.popAndPushNamed(context, LoginScreen.id);

              /// Write to the Device that the User has done the onboarding already
              await secureStorage.write(
                  key: 'onboardingCompleted', value: 'true');
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 10, right: 30),
              child: Text(
                'Skip',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: kLightPurple),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: contents.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: getProportionateScreenHeight(100),
                        left: getProportionateScreenWidth(31),
                        right: getProportionateScreenWidth(31)),
                    child: Column(children: [
                      SizedBox(
                        height: getProportionateScreenHeight(295),
                        width: getProportionateScreenWidth(330),
                        child: Image.asset(
                          contents[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        contents[index].tagline,
                        style: const TextStyle(
                            fontSize: 22,
                            fontFamily: 'Fira Code',
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                        textAlign: TextAlign.center,
                      )
                    ]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(20)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(contents.length, (index) {
                    return buildDot(index);
                  })),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30)),
              child: GeneralButton(
                text: currentIndex == contents.length - 1
                    ? 'Get Started'
                    : 'Next',
                onPressed: () async {
                  if (currentIndex == contents.length - 1) {
                    Navigator.popAndPushNamed(context, SignUpScreen.id);

                    /// Write to the Device that the User has done the onboarding already
                    await secureStorage.write(
                        key: 'onboardingCompleted', value: 'true');
                  }
                  _pageController!.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  /// Switch Indicator
  Container buildDot(int index) {
    return Container(
      height: getProportionateScreenHeight(8),
      width: currentIndex == index
          ? getProportionateScreenWidth(30)
          : getProportionateScreenWidth(8),
      margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ? kPrimaryColor : kTransparentPurple),
    );
  }
}
