import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/otp_verification.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const id = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// A variable to hold the key for the SignUp form
  final GlobalKey _formKey = GlobalKey();

  /// The [TextEditingController] for the First Name TextField
  final TextEditingController _firstNameController = TextEditingController();

  /// The [TextEditingController] for the Last Name TextField
  final TextEditingController _lastNameController = TextEditingController();

  /// The [TextEditingController] for the User Name TextField
  final TextEditingController _userNameController = TextEditingController();

  /// The [TextEditingController] for the Email Address TextField
  final TextEditingController _emailController = TextEditingController();

  /// The [TextEditingController] for the Phone Number TextField
  final TextEditingController _phoneNumberController = TextEditingController();

  /// The [TextEditingController] for the Password TextField
  final TextEditingController _passwordController = TextEditingController();

  /// The [TextEditingController] for the Confirm Password TextField
  final TextEditingController _confirmPassController = TextEditingController();

  /// Boolean for Password suffix Icon
  final bool _showPassword = true;

  /// Boolean for Terms and Conditions
  bool? _isAgreed = false;

  /// Boolean to show Validate Password Container
  //bool _showValidatePassword = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(backArrowIcon),
        ),
      ),
      body: const AuthenticationBackground(),
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return Container(
            color: kPrimaryColor,
            child: Container(
              width: double.infinity,
              height: SizeConfig.screenHeight! * 0.7,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(31),
                  vertical: getProportionateScreenHeight(30)),
              decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      'Create An Account',
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a User? ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, LoginScreen.id),
                          child: Text(
                            'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /// First Name
                          HpTextFormField(
                              controller: _firstNameController,
                              hintText: 'Enter First Name',
                              title: 'First Name',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          /// Last Name
                          HpTextFormField(
                              controller: _lastNameController,
                              hintText: 'Enter Last Name',
                              title: 'Last Name',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          /// Email Address
                          HpTextFormField(
                              controller: _emailController,
                              hintText: 'student@stu.cu.edu.ng',
                              title: 'Email Address',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          ///Username
                          HpTextFormField(
                              controller: _userNameController,
                              hintText: 'Enter your Unique Username',
                              title: 'Username',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          /// Phone Number
                          HpTextFormField(
                              controller: _phoneNumberController,
                              hintText: '08012345678',
                              title: 'Phone Number',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          /// Date Of Birth
                          HpTextFormField(
                              controller: _firstNameController,
                              hintText: 'Pick your Date of Birth',
                              title: 'Date of Birth',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          /// Email Address
                          HpTextFormField(
                              controller: _firstNameController,
                              hintText: 'Select Gender',
                              title: 'Gender',
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              }),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          ///Password
                          HpPasswordFormField(
                            controller: _passwordController,
                            hintText: 'Enter Password',
                            title: 'Password',
                            onChanged: (value) {
                              // setState(() {
                              //   _showValidatePassword = true;
                              //   if (value.isEmpty) {
                              //     setState(() {
                              //       _showValidatePassword = false;
                              //     });
                              //   }
                              // });
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                            obsureText: _showPassword,
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          ///Confirm Password
                          HpPasswordFormField(
                            controller: _confirmPassController,
                            hintText: 'Confirm Password',
                            title: 'Confirm Password',
                            onChanged: (value) {},
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                            obsureText: _showPassword,
                          ),
                          SizedBox(height: getProportionateScreenHeight(22)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _isAgreed,
                                onChanged: (value) {
                                  setState(() {
                                    _isAgreed = value;
                                  });
                                },
                                activeColor: kPrimaryColor,
                              ),
                              SizedBox(width: getProportionateScreenWidth(0)),
                              RichText(
                                text: TextSpan(
                                    text: "I hereby agree to the",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: " Terms and Conditions\n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      TextSpan(
                                          text: 'guiding this app.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ]),
                              )
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          _isAgreed == false
                              ? const InActiveGeneralButton(text: 'Register')
                              : GeneralButton(
                                  text: 'Register',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return OTPVerification(
                                        emailAddress: _emailController.text
                                            .trim()
                                            .toString(),
                                      );
                                    }));
                                  }),
                          SizedBox(height: getProportionateScreenHeight(10))
                        ],
                      ),
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
}
