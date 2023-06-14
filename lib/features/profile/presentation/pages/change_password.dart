// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:hebron_pay/size_config.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const id = '/changePassword';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  /// Global Formkey
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Variable to hold Current Password
  final TextEditingController _currentPasswordController =
      TextEditingController();

  /// Variable to hold The Re-entered Password
  final TextEditingController _passwordController = TextEditingController();

  /// Variable to hold The Re-entered Password
  final TextEditingController _reEnterPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            const message = "Password Successfully Changed";
            showSuccessSnackBar(context, message);
            Navigator.pop(context);
          }
          if (state is ProfileFailure) {
            final exception = (state).errorMessage;
            showErrorSnackBar(context, exception);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Form(
                key: _formKey,
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
                          if (validator!.isEmpty) {
                            return 'This Field cannot be empty';
                          }
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(12)),

                    /// Re Enter Password
                    HpPasswordFormField(
                        controller: _passwordController,
                        hintText: 'Enter your New Password',
                        title: 'New Password',
                        onChanged: (value) {},
                        obsureText: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return 'This Field cannot be empty';
                          }
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(12)),

                    /// Re Enter Password
                    HpPasswordFormField(
                        controller: _reEnterPasswordController,
                        hintText: 'Re-enter your New Password',
                        title: 'Confirm Password',
                        onChanged: (value) {},
                        obsureText: true,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (validator) {
                          if (validator!.isEmpty) {
                            return 'This Field cannot be empty';
                          }
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(35)),

                    /// General Button
                    GeneralButton(
                      text: 'Change Password',
                      onPressed: _submitChangePassword,
                      isLoading: _isLoading,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitChangePassword() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await BlocProvider.of<ProfileCubit>(context).changePassword({
      "currentPassword": _currentPasswordController.text,
      "newPassword": _passwordController.text,
      "confirmPassword": _reEnterPasswordController.text
    });
  }
}
