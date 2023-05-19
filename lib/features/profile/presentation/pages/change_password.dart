// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/password_textfield.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  static const id = '/changePassword';

  @override
  Widget build(BuildContext context) {
    /// Variable to hold Current Password
    TextEditingController _currentPasswordController = TextEditingController();

    /// Variable to hold The Re-entered Password
    TextEditingController _reEnterPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            backArrowIcon,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          'Change Password',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(40)),

              /// Current Password
              HpPasswordFormField(
                  controller: _currentPasswordController,
                  hintText: 'Enter your Current Password',
                  title: 'Current Password',
                  onChanged: (value) {},
                  obsureText: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  validator: (validator) {
                    return null;
                  }),
              SizedBox(height: getProportionateScreenHeight(12)),

              /// Re Enter Password
              HpPasswordFormField(
                  controller: _currentPasswordController,
                  hintText: 'Enter your New Password',
                  title: 'New Password',
                  onChanged: (value) {},
                  obsureText: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  validator: (validator) {
                    return null;
                  }),
              SizedBox(height: getProportionateScreenHeight(12)),

              /// Re Enter Password
              HpPasswordFormField(
                  controller: _currentPasswordController,
                  hintText: 'Re-enter your New Password',
                  title: 'Confirm Password',
                  onChanged: (value) {},
                  obsureText: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  validator: (validator) {
                    return null;
                  }),
              SizedBox(height: getProportionateScreenHeight(35)),

              /// General Button
              GeneralButton(text: 'Change Password', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
