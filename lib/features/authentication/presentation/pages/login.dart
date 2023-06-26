// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/domain/entities/login_entity.dart';
import 'package:hebron_pay/features/authentication/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/forgot_password.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/otp_verification.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/sign_up.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/size_config.dart';
import '../../../../core/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginEntity? userDetails;

  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// The [TextEditingController] for the Email Address TextField
  final TextEditingController _emailAddressController = TextEditingController();

  /// The [TextEditingController] for the Password TextField
  final TextEditingController _passwordController = TextEditingController();

  /// Boolean for Password suffix Icon
  final bool _showPassword = true;

  /// Boolean for Loading Button
  bool _isLoading = false;

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(backArrowIcon),
        ),
      ),
      body: const AuthenticationBackground(),
      bottomSheet: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            userDetails?.isOtpVerified == false
                ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OTPVerification(emailAddress: userDetails!.email);
                  }))
                : Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                    return DashBoard(
                      currentIndex: 0,
                    );
                  }), (route) => false);

            _emailAddressController.clear();
            _passwordController.clear();
          }
          if (state is LoginFailure) {
            final exception = (state).errorMessage;
            print(exception);
            showErrorSnackBar(context, exception);
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
          return AuthenticationBody(
            body: SingleChildScrollView(
              child: Column(children: [
                Center(
                    child: Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.displayMedium,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account? ",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SignUpScreen.id),
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ///Email Address
                      HpTextFormField(
                          controller: _emailAddressController,
                          hintText: 'student@stu.cu.edu.ng',
                          title: 'Email Address',
                          onChanged: (value) {},
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            String pattern =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            if (value!.isEmpty) {
                              return 'E-mail field cannot be empty';
                            } else {
                              RegExp regExp = RegExp(pattern);
                              if (regExp.hasMatch(value)) {
                                return null;
                              } else {
                                return 'Please use a VALID E-mail address';
                              }
                            }
                          }),
                      SizedBox(height: getProportionateScreenHeight(10)),

                      /// Password
                      HpPasswordFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        title: 'Password',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value!.toString().isEmpty) {
                            return "Password field can't be empty";
                          }
                          return null;
                        },
                        obsureText: _showPassword,
                      ),
                      SizedBox(height: getProportionateScreenHeight(12)),

                      ///Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ForgotPasswordScreen.id),
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kErrorColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),

                      /// Sign In Button
                      GeneralButton(
                          text: 'Sign In',
                          isLoading: _isLoading,
                          onPressed: () {
                            _submitLogin();
                          })
                    ],
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }

  void _submitLogin() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    userDetails = await BlocProvider.of<LoginCubit>(context).submitLogin(
        email: _emailAddressController.text.trim().toLowerCase(),
        password: _passwordController.text);
  }
}
