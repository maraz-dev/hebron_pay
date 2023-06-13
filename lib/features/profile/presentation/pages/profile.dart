import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_password.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_pin.dart';
import 'package:hebron_pay/features/profile/presentation/pages/help_and_support.dart';
import 'package:hebron_pay/features/profile/presentation/pages/privacy_policy.dart';
import 'package:hebron_pay/features/profile/presentation/pages/terms_and_condition.dart';
import 'package:hebron_pay/features/profile/presentation/widgets/profile_button.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.loggedInUser});

  static const id = "/profileScreen";

  final LoginEntity loggedInUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Center(
                child: Image.asset(
                  profileAvatar,
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenHeight(110),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),

              /// User Name
              Text(
                '${widget.loggedInUser.firstName} ${widget.loggedInUser.lastName}',
                style: Theme.of(context).textTheme.displaySmall,
              ),

              /// View Profile Button
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View Profile',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: kLightPurple),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),

              ///Change Password
              ProfileButton(
                icon: changePasswordIcon,
                title: 'Change Password',
                onPressed: () {
                  Navigator.pushNamed(context, ChangePasswordScreen.id);
                },
              ),

              /// Change Pin
              ProfileButton(
                title: 'Change Pin',
                icon: changePinIcon,
                onPressed: () {
                  Navigator.pushNamed(context, ChangePinScreen.id);
                },
              ),

              /// Terms and Condition
              ProfileButton(
                title: 'Terms and Condition',
                icon: termsAndConditionIcon,
                onPressed: () {
                  Navigator.pushNamed(context, TermsAndConditionScreen.id);
                },
              ),

              /// Privacy Policy
              ProfileButton(
                title: 'Privacy Policy',
                icon: privacyIcon,
                onPressed: () {
                  Navigator.pushNamed(context, PrivacyPolicyScreen.id);
                },
              ),

              /// Help and Support
              ProfileButton(
                title: 'Help and Support',
                icon: helpAndSupportIcon,
                onPressed: () {
                  Navigator.pushNamed(context, HelpAndSupportScreen.id);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(25)),

              /// Log Out Button
              LogOutButton(
                  text: 'Log Out',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
