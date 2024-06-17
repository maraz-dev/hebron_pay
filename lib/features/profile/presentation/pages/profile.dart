import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/bloc/cubit/user_details_cubit.dart';
import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_password.dart';
import 'package:hebron_pay/features/profile/presentation/pages/change_pin.dart';
import 'package:hebron_pay/features/profile/presentation/pages/show_account_details.dart';
import 'package:hebron_pay/features/profile/presentation/widgets/profile_button.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  static const id = "/profileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserEntity? currentUserEntity;

  /// Get User Details
  void _getCurrentUser() async {
    var currentUser =
        await BlocProvider.of<UserDetailsCubit>(context).userUsecase();
    currentUserEntity = currentUser;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return DashBoard(
              currentIndex: 0,
            );
          }), (route) => false);
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
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
                BlocConsumer<UserDetailsCubit, UserDetailsState>(
                  listener: (context, state) {
                    if (state is UserDetailsFailure) {
                      showErrorSnackBar(context, (state).errorMessage);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserDetailsLoading) {
                      _isLoading = true;
                    } else {
                      _isLoading = false;
                    }
                    if (state is UserDetailsSuccess) {
                      currentUserEntity = (state).userEntity;
                    }
                    return _isLoading
                        ? Container()
                        : currentUserEntity == null
                            ? const Text('')
                            : Text(
                                '${currentUserEntity!.firstName} ${currentUserEntity!.lastName}',
                                style: Theme.of(context).textTheme.displaySmall,
                              );
                  },
                ),

                /// View Profile Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ShowAccountDetails();
                    }));
                  },
                  child: Text(
                    'Show Account Details',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: kLightPurple, fontSize: 16),
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
                  title: 'Terms and Conditions',
                  icon: termsAndConditionIcon,
                  onPressed: () {
                    showSuccessSnackBar(context, 'Available in Version 2.0');
                    //Navigator.pushNamed(context, TermsAndConditionScreen.id);
                  },
                ),

                /// Privacy Policy
                ProfileButton(
                  title: 'Privacy Policy',
                  icon: privacyIcon,
                  onPressed: () {
                    showSuccessSnackBar(context, 'Available in Version 2.0');
                    //Navigator.pushNamed(context, PrivacyPolicyScreen.id);
                  },
                ),

                /// Help and Support
                ProfileButton(
                  title: 'Help and Support',
                  icon: helpAndSupportIcon,
                  onPressed: () {
                    showSuccessSnackBar(context, 'Available in Version 2.0');
                    //Navigator.pushNamed(context, HelpAndSupportScreen.id);
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(25)),

                /// Log Out Button
                LogOutButton(
                    text: 'Log Out',
                    onPressed: () {
                      _clearSecureStorage();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.id, (route) => false);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Clears Everything you've saved in the Storage on Logout
  void _clearSecureStorage() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.deleteAll();
  }
}
